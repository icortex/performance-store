class ClothTypesController < ApplicationController
  # GET /cloth_types
  # GET /cloth_types.xml
  def index
    @cloth_types = ClothType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cloth_types }
    end
  end

  # GET /cloth_types/1
  # GET /cloth_types/1.xml
  def show
    @cloth_type = ClothType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cloth_type }
    end
  end

  # GET /cloth_types/new
  # GET /cloth_types/new.xml
  def new
    @cloth_type = ClothType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cloth_type }
    end
  end

  # GET /cloth_types/1/edit
  def edit
    @cloth_type = ClothType.find(params[:id])
  end

  # POST /cloth_types
  # POST /cloth_types.xml
  def create
    @cloth_type = ClothType.new(params[:cloth_type])

    respond_to do |format|
      if @cloth_type.save
        format.html { redirect_to(@cloth_type, :notice => 'Cloth type was successfully created.') }
        format.xml  { render :xml => @cloth_type, :status => :created, :location => @cloth_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cloth_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cloth_types/1
  # PUT /cloth_types/1.xml
  def update
    @cloth_type = ClothType.find(params[:id])

    respond_to do |format|
      if @cloth_type.update_attributes(params[:cloth_type])
        format.html { redirect_to(@cloth_type, :notice => 'Cloth type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cloth_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cloth_types/1
  # DELETE /cloth_types/1.xml
  def destroy
    @cloth_type = ClothType.find(params[:id])
    @cloth_type.destroy

    respond_to do |format|
      format.html { redirect_to(cloth_types_url) }
      format.xml  { head :ok }
    end
  end
end
