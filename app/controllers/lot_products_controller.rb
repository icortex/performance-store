class LotProductsController < ApplicationController
  # GET /lot_products
  # GET /lot_products.xml
  def index
    @lot_products = LotProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lot_products }
    end
  end

  # GET /lot_products/1
  # GET /lot_products/1.xml
  def show
    @lot_product = LotProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lot_product }
    end
  end

  # GET /lot_products/new
  # GET /lot_products/new.xml
  def new
    @lot_product = LotProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lot_product }
    end
  end

  # GET /lot_products/1/edit
  def edit
    @lot_product = LotProduct.find(params[:id])
  end

  # POST /lot_products
  # POST /lot_products.xml
  def create
    @lot_product = LotProduct.new(params[:lot_product])

    respond_to do |format|
      if @lot_product.save
        format.html { redirect_to(@lot_product, :notice => 'Lot product was successfully created.') }
        format.xml  { render :xml => @lot_product, :status => :created, :location => @lot_product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lot_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lot_products/1
  # PUT /lot_products/1.xml
  def update
    @lot_product = LotProduct.find(params[:id])

    respond_to do |format|
      if @lot_product.update_attributes(params[:lot_product])
        format.html { redirect_to(@lot_product, :notice => 'Lot product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lot_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lot_products/1
  # DELETE /lot_products/1.xml
  def destroy
    @lot_product = LotProduct.find(params[:id])
    @lot_product.destroy

    respond_to do |format|
      format.html { redirect_to(lot_products_url) }
      format.xml  { head :ok }
    end
  end
end
