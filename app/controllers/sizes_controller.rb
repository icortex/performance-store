class SizesController < MyApplicationController

  layout 'application', :except=>['new', 'edit']

  def index
    @sizes = Size.all
  end

  def new
    @size = Size.new
  end

  def edit
    @size = Size.find(params[:id])
  end

  def create
    @size = Size.new(params[:size])

    respond_to do |format|
      if @size.save
        format.html { redirect_to(admin_index_path, :notice => 'Talla creada exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @size = Size.find(params[:id])

    respond_to do |format|
      if @size.update_attributes(params[:size])
        format.html { redirect_to(admin_index_path, :notice => 'Talla actualizada exitosamente!.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @size = Size.find(params[:id])
    @size.destroy

    redirect_to(:back, :notice => 'Talla borrada exitosamente.')
  end
end
