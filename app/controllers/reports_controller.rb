class ReportsController < MyApplicationController

  include ActionView::Helpers::TextHelper
  def index
    respond_to do |format|
      format.css
      format.html do
        if request.post? && (params[:start_date] || params[:end_date])
          first_day = Date.strptime(params[:start_date]) rescue Date.today.prev_month
          end_day = ((Date.strptime params[:end_date])+2.days) rescue Date.today + 2.days

          first_day, end_day = end_day, first_day if first_day > end_day
          end_day = end_day > Date.today + 2.days ? Date.today + 2.days : end_day

          first_day_s= first_day.to_s
          end_day_s= end_day.to_s
          separations_results = chart_helper(first_day_s, end_day_s,'separate',['payment','payment_cost'],'ss.created_at',"s.separated=1 and s.headquarter_id=#{params[:headquarter]} and", 'as ss join sales as s on ss.sale_id=s.id')
          sales_results = chart_helper(first_day_s, end_day_s,'sale',['total','total_cost'],'created_at', "separated=0 and headquarter_id=#{params[:headquarter]} and")
          expenses_results = chart_helper(first_day_s, end_day_s,'expense',['cost'],'created_at',"headquarter_id=#{params[:headquarter]} and",'','expense_type_id')
          expenses_day = chart_helper(first_day_s, end_day_s,'expense',['cost'],'created_at',"headquarter_id=#{params[:headquarter]} and")
          lots_results = chart_helper(first_day_s, end_day_s,'lot',['freight'],'arrival_date')
          sales = sales_results[0]
          separates = separations_results[0]
          @op_expenses =   expenses_results[0][0] ? expenses_results[0][0].cost : 0
          @s_expenses = expenses_results[0][1] ? expenses_results[0][1].cost : 0
          @ot_expenses = expenses_results[0][2] ? expenses_results[0][2].cost : 0
          @sales=sales_results[1][0] + separations_results[1][0]
          @sales_cost=sales_results[1][1]+separations_results[1][1]
          @gross_profit=@sales-@sales_cost
          @expenses=@op_expenses+@s_expenses+@ot_expenses
          @freight=lots_results[1][0]
          @before_taxes_reserve_profit=@gross_profit-@expenses
          @taxes=Variable.find(4).value.to_f/100 * zero_if_neg(@before_taxes_reserve_profit)
          @reserve=Variable.find(5).value.to_f/100 * zero_if_neg(@before_taxes_reserve_profit)
          @net_profit=@before_taxes_reserve_profit-@taxes-@reserve
          @chart= (first_day...end_day).map do |day|
            sale= search_date_in_array(sales, day)
            sale = sale == 0 ? {:total => 0, :total_cost => 0} : sale
            separate=search_date_in_array(separates, day)
            separate = separate == 0 ? {:payment => 0, :payment_cost => 0} : separate
            day_expense=search_date_in_array(expenses_day[0], day, 'cost')
            day_income=sale[:total]+separate[:payment]
            day_costs=sale[:total_cost]+separate[:payment_cost]
            day_gross_util= day_income - day_costs
            [day.to_s, day_income, day_expense, day_gross_util]
          end
          @chart.map! do |chart|
            if chart[1..3]==[0, 0, 0]
            else
              break
            end
          end
          @chart.delete_if { |c| c==nil }
          @chart=[['',0,0,0]] if @chart.empty?
          hq=Headquarter.find params[:headquarter]
          @title='Reporte en '+hq.name
        elsif request.get?
          @title='Generar reporte'
        end

      end
    end
  end

  #  Usage example:
  #  sales_results = chart_helper(first_day_s, end_day_s,'sale',['total','total_cost'])
  #  sales = sales_results[0]  # array with sales per day
  #  sales_total = sales_results[1][0]
  #  sales_total_cost = sales_results[1][1]
  def chart_helper(start_date, end_date, model, columns, date='created_at', where_modifier = '',join_modifier='', group='')
    statement = build_statement(start_date, end_date, model, columns, date, where_modifier,join_modifier,group)
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

  def build_statement(start_date, end_date, model, columns, date, where_modifier = '',join_modifier='',group='')
    statement='select *'
    columns.each { |c| statement+=",sum(#{c}) as #{c}" }
    statement+=" from #{pluralize(2,model).sub(/[2] /,'')} #{join_modifier} " +
        "where #{where_modifier} #{date} > '#{start_date}' "+
        "and #{date} < '#{end_date}' "
    statement+="group by date(#{date})" if group.blank?
    statement+="group by #{group}" if !group.blank?
    statement
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
