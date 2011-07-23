class ProductsController < MyApplicationController

  include ProductsHelper

  def index

    @products= Product.where('reference like ?', "%#{params[:q]}%")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => organize(@products) }
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
    @products = Product.find_all_by_reference(@product.reference)
    @colors =Color.find(@products.map(&:color_id)).map(&:color).uniq
    @sizes =Size.find(@products.map(&:size_id)).map(&:size).uniq
  end

  def create
    success=true

    set_default_color_size

    colors = params[:color_ids].values
    sizes = params[:size_ids].values

    colors.each do |color_id|
      params[:product][:color_id]=color_id
      sizes.each do |size_id|
        params[:product][:size_id]=size_id
        @product = Product.new(params[:product])
        if !@product.save
          success=false
        end
      end
    end

    respond_to do |format|
      if success
        format.html { redirect_to(new_product_path, :notice => 'Articulo creado exitosamente!') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    success=true

    set_default_color_size

    colors = params[:color_ids].values
    sizes = params[:size_ids].values

    colors.each do |color_id|
      params[:product][:color_id]=color_id
      sizes.each do |size_id|
        params[:product][:size_id]=size_id
        product=search_size_color @products,size_id,color_id
        if !product.update_attributes(params[:product])
          success=false
        end
      end
    end

#    Color.all.map(&:id).each do |color_id|
#      params[:product][:color_id]=color_id
#    Size.all.map(&:id).each do |size_id|
#      params[:product][:size_id]=size_id
#      product=search_size_color @products,size_id,color_id
#
#    end
#    end

    respond_to do |format|
      if success
        format.html { redirect_to(new_product_path, :notice => 'Articulo creado exitosamente!') }
      else
        format.html { render :action => "new" }
      end
    end
#    params[:product][:brand] = Brand.find(params[:product][:brand])
#    params[:product][:cloth_type] = ClothType.find(params[:product][:cloth_type])
#
#    set_default_color_size
#
#    @product = Product.find(params[:id])
#
#    respond_to do |format|
#      if @product.update_attributes(params[:product])
#        format.html { redirect_to(@product, :notice => 'Articulo actualizado exitosamente!') }
#        format.xml { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
#      end
#    end
  end

  def destroy
    @product = Product.find(params[:id])
    @products = Product.find_all_by_reference(@product.reference)
    Product.destroy @products

    respond_to do |format|
      format.html { redirect_to(products_url, :notice => 'Articulo borrado exitosamente!') }
      format.xml { head :ok }
    end
  end

   def search_size_color array,size_id,color_id
    ret_val=false
    array.each do |el|
      if el.size_id==size_id && el.color_id==color_id
        ret_val=el
      end
    end
    ret_val
  end
end
