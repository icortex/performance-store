class VariablesController < MyApplicationController

  layout false

  def index
    @variables = Variable.all
  end

  def edit
    @variable = Variable.find(params[:id])
  end

  def update
    @variable = Variable.find(params[:id])

    respond_to do |format|
      if @variable.update_attributes(params[:variable])
        format.html { redirect_to(admin_index_path, :notice => 'Variable actualizada exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
