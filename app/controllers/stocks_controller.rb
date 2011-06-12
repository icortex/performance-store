class StocksController < ApplicationController
  layout 'application', :except=>'new'

  # GET /stocks
  # GET /stocks.xml
  def index
    @stocks = Stock.find_all_by_headquarter_id (Headquarter.find_by_name params[:headquarter]).id
    @headquarters = Headquarter.all
    @headquarter = params[:headquarter]

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @stocks }
    end
  end

  # GET /stocks/1
  # GET /stocks/1.xml
  def show
    @stock = Stock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @stock }
    end
  end

  # GET /stocks/new
  # GET /stocks/new.xml
  def new

    @stock = Stock.new :product_id => params[:product_id]
    p @stock.product_id

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @stock }
    end
  end

  # GET /stocks/1/edit
  def edit
    @stock = Stock.find(params[:id])
  end

  # POST /stocks
  # POST /stocks.xml
  def create
    params[:stock][:product]= Product.find params[:stock][:product_id]
    params[:stock][:headquarter] = Headquarter.find(params[:stock][:headquarter])
    @stock = Stock.new(params[:stock])

    respond_to do |format|
      if @stock.save
        format.html { redirect_to(products_path, :notice => 'El producto fue agregado al inventario exitosamente.') }
        format.xml { render :xml => @stock, :status => :created, :location => @stock }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @stock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stocks/1
  # PUT /stocks/1.xml
  def update
    params[:stock][:headquarter] = Headquarter.find(params[:stock][:headquarter])
    @stock = Stock.find(params[:id])

    respond_to do |format|
      if @stock.update_attributes(params[:stock])
        format.html { redirect_to(:back, :notice => 'Inventario actualizado exitosamente!') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @stock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.xml
  def destroy
    @stock = Stock.find(params[:id])
    @stock.product.destroy
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'Articulo borrado exitosamente!') }
      format.xml { head :ok }
    end
  end

end
