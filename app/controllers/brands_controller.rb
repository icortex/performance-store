class BrandsController < MyApplicationController

  layout 'application', :except=>['new', 'edit']

  load_and_authorize_resource
  check_authorization

  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def create
    @brand = Brand.new(params[:brand])

    respond_to do |format|
      if @brand.save
        format.html { redirect_to(:back, :notice => 'Marca creada exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @brand = Brand.find(params[:id])

    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to(admin_index_path, :notice => 'Marca actualizada exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
redirect_to(admin_index_path, :notice => 'Marca borrada exitosamente.')
  end
end
