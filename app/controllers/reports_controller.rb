class ReportsController < MyApplicationController

  def index
    respond_to do |format|
      format.css
      format.html do
        if request.post? && (params[:start_date] || params[:end_date])
          first_day = Date.strptime(params[:start_date]) rescue Date.today.prev_month
          end_day = ((Date.strptime params[:end_date])+1.days) rescue Date.today + 1.days

          first_day, end_day = end_day, first_day if first_day > end_day
          end_day = end_day > Date.today + 1.days ?  Date.today + 1.days : end_day

          first_day_s= first_day.to_s
          end_day_s= end_day.to_s
          sales = get_sales(first_day_s, end_day_s)
          expenses = get_expenses(first_day_s, end_day_s)
          @sales=zero_if_nil sales.map(&:total).inject{|sum,x| sum + x }
          @sales_cost=zero_if_nil sales.map(&:total_cost).inject{|sum,x| sum + x }
          @gross_profit=@sales-@sales_cost
          @expenses=zero_if_nil expenses.map(&:cost).inject{|sum,x| sum + x }
          @before_taxes_reserve_profit=@gross_profit-@expenses
          @taxes=Variable.find(4).value.to_f* zero_if_neg(@before_taxes_reserve_profit)
          @reserve=Variable.find(5).value.to_f* zero_if_neg(@before_taxes_reserve_profit)
          @net_profit=@before_taxes_reserve_profit-@taxes-@reserve
          @chart= (first_day...end_day).map do |day|
            sale_aux= search_date(sales,day)
            sale = sale_aux == 0 ? {:total => 0 , :total_cost => 0} : sale_aux
            [day.to_s, sale[:total],search_date(expenses,day,'cost'), sale[:total]-sale[:total_cost]]
          end
          @chart.map! do |chart|
            if chart[1..3]==[0,0,0]
            else
              break
            end
          end
          @chart.delete_if { |c| c==nil}
        end

      end
    end
  end

  def get_sales(start_date, end_date)
    sale_statement = "select *, sum(total) as total, sum(total_cost) as total_cost "+
              "from sales where created_at > '#{start_date}' "+
              "and created_at < '#{end_date}' group by date(created_at)"
    sales= Sale.find_by_sql(sale_statement)
    sales.each do |sale|
       sale.total_cost=0 if sale.total_cost.nil?
       sale.total=0 if sale.total.nil?
    end
    sales
  end

  def get_expenses(start_date, end_date)
          expenses_statement = "select *, sum(cost) as cost "+
              "from expenses where created_at > '#{start_date}' "+
              "and created_at < '#{end_date}' group by date(created_at)"
    expenses=Expense.find_by_sql(expenses_statement)
    expenses.each do |e|
      e.cost=0 if e.cost.nil?
    end
    expenses
  end

  def search_date array,date,return_property=nil
    ret_val=0
    array.each do |el|
      if el.created_at.to_datetime.to_date == date
        if return_property.nil?
          ret_val=el
        else
          ret_val=el[return_property]
        end
      end
    end
    ret_val
  end

  def zero_if_nil arg
    arg.nil? ? 0 : arg
  end

  def zero_if_neg arg
    arg < 0 ? 0 : arg
  end
end
