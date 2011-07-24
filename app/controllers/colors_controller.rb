class ColorsController < MyApplicationController

  layout 'application', :except=>['new', 'edit']

  def index
    @colors = Color.all
  end

  def new
    @color = Color.new
  end

  def edit
    @color = Color.find(params[:id])
  end

  def create
    @color = Color.new(params[:color])

    respond_to do |format|
      if @color.save
        format.html { redirect_to(admin_index_path, :notice => 'Color creado exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @color = Color.find(params[:id])

    respond_to do |format|
      if @color.update_attributes(params[:color])
        format.html { redirect_to(admin_index_path, :notice => 'Color actualizado exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @color = Color.find(params[:id])
    @color.destroy

    redirect_to(admin_index_path, :notice => 'Color borrado exitosamente.')
  end
end
