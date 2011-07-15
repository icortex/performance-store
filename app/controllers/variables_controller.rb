class VariablesController < ApplicationController

  layout false
  
  # GET /variables
  # GET /variables.xml
  def index
    @variables = Variable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @variables }
    end
  end

  # GET /variables/1/edit
  def edit
    @variable = Variable.find(params[:id])
  end

  # PUT /variables/1
  # PUT /variables/1.xml
  def update
    @variable = Variable.find(params[:id])

    respond_to do |format|
      if @variable.update_attributes(params[:variable])
        format.html { redirect_to(@variable, :notice => 'Variable was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @variable.errors, :status => :unprocessable_entity }
      end
    end
  end
end
