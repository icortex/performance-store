class SaleProductsController < ApplicationController
  # GET /sale_products
  # GET /sale_products.xml
  def index
    @sale_products = SaleProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @sale_products }
    end
  end

  # GET /sale_products/1
  # GET /sale_products/1.xml
  def show
    @sale_product = SaleProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @sale_product }
    end
  end

  # GET /sale_products/new
  # GET /sale_products/new.xml
  def new
    @sale_product = SaleProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @sale_product }
    end
  end

  # GET /sale_products/1/edit
  def edit
    @sale_product = SaleProduct.find(params[:id])
  end

  # POST /sale_products
  # POST /sale_products.xml
  def create
    #params[:sale_product][:sale_id] = params[:sale_product][:sale_id] ? params[:sale_product][:sale_id] : @sale.id
    @sale_product = SaleProduct.new(params[:sale_product])

    respond_to do |format|
      if @sale_product.save
        format.html { redirect_to(@sale_product, :notice => 'Sale product was successfully created.') }
        format.xml { render :xml => @sale_product, :status => :created, :location => @sale_product }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @sale_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sale_products/1
  # PUT /sale_products/1.xml
  def update
    @sale_product = SaleProduct.find(params[:id])

    respond_to do |format|
      if @sale_product.update_attributes(params[:sale_product])
        format.html { redirect_to(@sale_product, :notice => 'Sale product was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @sale_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_products/1
  # DELETE /sale_products/1.xml
  def destroy
    @sale_product = SaleProduct.find(params[:id])
    @sale_product.destroy

    respond_to do |format|
      format.html { redirect_to(sale_products_url) }
      format.xml { head :ok }
    end
  end
end
