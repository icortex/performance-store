class ExpensesController < MyApplicationController

  def index
    @expenses = Expense.all
  end

  def new
    @expense = Expense.new
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def create
    params[:expense][:headquarter_id]=current_user.headquarter_id
    @expense = Expense.new(params[:expense])

    respond_to do |format|
      if @expense.save
        format.html { redirect_to(expenses_path, :notice => 'Gasto creado exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    params[:expense][:headquarter_id]=current_user.headquarter_id
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to(expenses_path, :notice => 'Gasto actualizado exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to(:back, :notice => 'Gasto borrado exitosamente.')
  end
end
