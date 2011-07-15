class ProductsController < ApplicationController


  # GET /products
  # GET /products.xml
  def index

    @products= Product.where('reference like ?', "%#{params[:q]}%")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => product_features(@products) }
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

    respond_to do |format|
      format.html # edit.html.erb
      format.xml { render :xml => @products }
    end
  end

  # POST /products
  # POST /products.xml
  def create
    success=true
    params[:product][:brand] = Brand.find(params[:product][:brand])
    params[:product][:cloth_type] = ClothType.find(params[:product][:cloth_type])

    set_default_color_size

    colors = params[:product][:color]
    sizes = params[:product][:size]

    colors.each do |ck, color|
      params[:product][:color]=Color.find(color)
      sizes.each do |sk, size|
        params[:product][:size]=Size.find(size)
        @product = Product.new(params[:product])
        if !@product.save
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

    set_default_color_size

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

  def set_default_color_size
    if  !params[:product][:size]
      params[:product][:size]=[[Size.find(1).size, "1"]]
    end
    if  !params[:product][:color]
      params[:product][:color]=[[Color.find(1).color, "1"]]
    end
  end

 #[{:reference => 'perro', :brand => 'Adidas',  :features => {'s' =>{'am'=>[1,20], 'm'=> {'ne'=>[21,2]}}}}, {}]

  def product_features products
    products_modified=[]

    products.each do |p|
      stocks_by_hq = p.stocks.find_by_headquarter_id(current_user.headquarter_id)
      qty = stocks_by_hq.quantity rescue 0
      price = stocks_by_hq.price rescue 0

      appended=false

      pm_temp = {}
      products_modified.each do |pm|
        if (p.reference == pm[:reference])
          pm[:features].each do |size, color|
            if size == p.size.size
              pm_temp[:features]= pm[:features]
              pm_temp[:features][size] = color
            else
              #pm[:features]['L'] = color
            end
          end
          appended=true
          break
        end
        pm[:features]=pm_temp[:features]
      end

      if !appended
        product_temp = {}
        product_temp[:id] = p.id
        product_temp[:brand] = p.brand.brand
        product_temp[:reference] = p.reference
        feature_to_insert ={}
        feature_to_insert[p.size.size] = {}
        feature_to_insert[p.size.size][p.color.color] = [qty, price]
        product_temp[:features] = feature_to_insert
        products_modified << product_temp
      end
    end
    products_modified
  end
end
