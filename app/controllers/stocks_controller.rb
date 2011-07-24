class StocksController < MyApplicationController
  layout 'application', :except=>['new', 'edit']

  def index
    @stocks = Stock.find_all_by_headquarter_id (Headquarter.find_by_name params[:headquarter]).id
    @headquarter = params[:headquarter]
  end

  def new
    @stock = Stock.new :product_id => params[:product_id]
  end

  def edit
    @stock = Stock.find(params[:id])
  end

  def create
    @stock = Stock.new(params[:stock])

    respond_to do |format|
      if @stock.save
        format.html { redirect_to(products_path, :notice => 'El producto fue agregado al inventario exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @stock = Stock.find(params[:id])

    respond_to do |format|
      if @stock.update_attributes(params[:stock])
        format.html { redirect_to(:back, :notice => 'Inventario actualizado exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy

    redirect_to(:back, :notice => 'Inventario borrado exitosamente.')
  end
end
