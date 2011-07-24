class ReportsController < MyApplicationController

  include ActionView::Helpers::TextHelper
  def index
    respond_to do |format|
      format.css
      format.html do
        if request.post? && (params[:start_date] || params[:end_date])
          first_day = Date.strptime(params[:start_date]) rescue Date.today.prev_month
          end_day = ((Date.strptime params[:end_date])+1.days) rescue Date.today + 1.days

          first_day, end_day = end_day, first_day if first_day > end_day
          end_day = end_day > Date.today + 1.days ? Date.today + 1.days : end_day

          first_day_s= first_day.to_s
          end_day_s= end_day.to_s
          sales_results = chart_helper(first_day_s, end_day_s,'sale',['total','total_cost'])
          sales = sales_results[0]
          expenses_results = chart_helper(first_day_s, end_day_s,'expense',['cost'])
          expenses = expenses_results[0]
          lots_results = chart_helper(first_day_s, end_day_s,'lot',['freight'],'arrival_date')
          @sales=sales_results[1][0]
          @sales_cost=sales_results[1][1]
          @gross_profit=@sales-@sales_cost
          @expenses=expenses_results[1][0]+lots_results[1][0]
          @before_taxes_reserve_profit=@gross_profit-@expenses
          @taxes=Variable.find(4).value.to_f/100 * zero_if_neg(@before_taxes_reserve_profit)
          @reserve=Variable.find(5).value.to_f/100 * zero_if_neg(@before_taxes_reserve_profit)
          @net_profit=@before_taxes_reserve_profit-@taxes-@reserve
          @chart= (first_day...end_day).map do |day|
            sale_aux= search_date_in_array(sales, day)
            sale = sale_aux == 0 ? {:total => 0, :total_cost => 0} : sale_aux
            [day.to_s, sale[:total], search_date_in_array(expenses, day, 'cost'), sale[:total]-sale[:total_cost]]
          end
          p 'ddddddddddddddddddddddddddd'
          p @chart
          @chart.map! do |chart|
            if chart[1..3]==[0, 0, 0]
            else
              break
            end
          end
          @chart.delete_if { |c| c==nil }
        end

      end
    end
  end

  #  Usage example:
  #  sales_results = chart_helper(first_day_s, end_day_s,'sale',['total','total_cost'])
  #  sales = sales_results[0]  # array with sales per day
  #  sales_total = sales_results[1][0]
  #  sales_total_cost = sales_results[1][1]
  def chart_helper(start_date, end_date, model, columns, date='created_at')
    statement='select *'
    columns.each { |c| statement+=",sum(#{c}) as #{c}" }
    statement+=" from #{pluralize(2,model).sub(/[2] /,'')} where #{date} > '#{start_date}' "+
        "and #{date} < '#{end_date}' group by date(#{date})"
    results=eval(model.capitalize).find_by_sql(statement)
    sums=Array.new columns.length
    index=0
    columns.each do |c|
      sum=0
      results.each do |r|
        r[c]=zero_if_nil r[c]
        sum+=r[c]
      end
      sums[index]=sum
      index+=1
    end
    [results, sums]
  end


  def search_date_in_array array, date, return_property=nil
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
