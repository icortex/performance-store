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
        format.html { redirect_to(@variable, :notice => 'Variable actualizada exitosamente.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @variable.errors, :status => :unprocessable_entity }
      end
    end
  end
end
