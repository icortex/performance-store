class LotsController < MyApplicationController

  load_and_authorize_resource
  check_authorization

  def index
    @lots = Lot.all
  end

  def show
    @lot = Lot.find(params[:id])
  end

  def new
    @lot = Lot.new
  end

  def edit
    @lot = Lot.find(params[:id])
  end

  def create
    @lot = Lot.new(params[:lot])

    respond_to do |format|
      if @lot.save
        format.html { redirect_to(lots_path, :notice => 'Lote creado exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @lot = Lot.find(params[:id])

    respond_to do |format|
      if @lot.update_attributes(params[:lot])
        format.html { redirect_to(lots_path, :notice => 'Lote actualizado exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @lot = Lot.find(params[:id])
    @lot.destroy

    redirect_to(:back, :notice => 'Lote borrado exitosamente.')
  end
end
