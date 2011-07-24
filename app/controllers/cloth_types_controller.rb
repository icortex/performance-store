class ClothTypesController < MyApplicationController

  layout 'application', :except=>['new', 'edit']

  def index
    @cloth_types = ClothType.all
  end

  def new
    @cloth_type = ClothType.new
  end

  def edit
    @cloth_type = ClothType.find(params[:id])
  end

  def create
    @cloth_type = ClothType.new(params[:cloth_type])

    respond_to do |format|
      if @cloth_type.save
        format.html { redirect_to(admin_index_path, :notice => 'Tipo de prenda creado exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @cloth_type = ClothType.find(params[:id])

    respond_to do |format|
      if @cloth_type.update_attributes(params[:cloth_type])
        format.html { redirect_to(admin_index_path, :notice => 'Tipo de prenda actualizada exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @cloth_type = ClothType.find(params[:id])
    @cloth_type.destroy

    redirect_to(admin_index_path, :notice => 'Tipo de prenda borrado exitosamente.')
  end
end
