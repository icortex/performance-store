class StocksController < MyApplicationController
  layout 'application', :except=>['new', 'edit']

  def index
    params[:headquarter] ||= current_user.headquarter.name
    @stocks = Stock.find_all_by_headquarter_id (Headquarter.find_by_name params[:headquarter]).id
    @headquarter = params[:headquarter]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    hq_id=params[:stock][:headquarter_id]
    lp_id=params[:stock][:lot_product_id]
    @stock=Stock.where('headquarter_id = ? and lot_product_id = ?',hq_id,lp_id)[0]
    @stock = Stock.new(params[:stock]) if @stock.nil?
    p @stock
  end

  def edit
    @stock = Stock.find(params[:id])
  end

  def create
    @stock = Stock.new(params[:stock])

    respond_to do |format|
      if @stock.save
        format.html { redirect_to(:back, :notice => 'El producto fue agregado al inventario exitosamente.') }
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
