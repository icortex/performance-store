class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    @stocks = Stock.all
    @headquarters = Headquarter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    success=true
    params[:product][:brand] = Brand.find(params[:product][:brand])
    params[:product][:cloth_type] = ClothType.find(params[:product][:cloth_type])

    if  !params[:product][:size]
      params[:product][:size]=[[Size.find(1).size, "1"]]
    end
    if  !params[:product][:color]
      params[:product][:color]=[[Color.find(1).color, "1"]]
    end

    sizes = params[:product][:size]
    colors = params[:product][:color]
    
    colors.each do |ck,color|
      params[:product][:color]=Color.find(color)
      sizes.each do |sk, size|
        params[:product][:size]=Size.find(size)
        @product = Product.new(params[:product])
        if @product.save
          Stock.create(:product => @product, :headquarter=>Headquarter.find(1))
        else
          success=false
        end
      end
    end
    respond_to do |format|
      if success
        format.html { redirect_to(new_product_path, :notice => 'Articulo creado exitosamente!') }
        format.xml { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    params[:product][:brand] = Brand.find(params[:product][:brand])
    params[:product][:cloth_type] = ClothType.find(params[:product][:cloth_type])
    params[:product][:size] = Size.find(params[:product][:size])
    params[:product][:color] = Color.find_by_rgb(params[:product][:color])
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Articulo actualizado exitosamente!') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url, :notice => 'Articulo borrado exitosamente!') }
      format.xml { head :ok }
    end
  end
end
