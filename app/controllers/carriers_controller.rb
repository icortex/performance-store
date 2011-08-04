class CarriersController < MyApplicationController

  def index
    @carriers = Carrier.all
  end

  def new
    @carrier = Carrier.new
  end

  def edit
    @carrier = Carrier.find(params[:id])
  end

  def create
    @carrier = Carrier.new(params[:carrier])

    respond_to do |format|
      if @carrier.save
        format.html { redirect_to(carriers_path, :notice => 'Transportador creado exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @carrier = Carrier.find(params[:id])

    respond_to do |format|
      if @carrier.update_attributes(params[:carrier])
        format.html { redirect_to(carriers_path, :notice => 'Transportador actualizado exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @carrier = Carrier.find(params[:id])
    @carrier.destroy

    redirect_to(carriers_url, :notice => 'Transportador borrado exitosamente.')
  end
end
