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
    success_aux=true
    success=true
    reference = Product.find(params[:id]).reference
    products = Product.find_all_by_reference(reference)

    set_default_color_size

    #update and destroy
    products.each do |old_product|
      color_size=search_size_color old_product, params[:size_ids], params[:color_ids]
      if color_size
        params[:product][:color_id]=color_size[0]
        params[:product][:size_id]=color_size[1]
        success_aux=old_product.update_attributes(params[:product])
        success=false if !success_aux
      else
        success_aux=old_product.destroy
        success=false if !success_aux
      end
    end

    #create new ones
    product_colors=products.map(&:color_id)
    product_sizes=products.map(&:size_id)
    params[:size_ids].values.each do |s|
      params[:color_ids].values.each do |c|
        if !product_colors.include?(c) && !product_sizes.include?(s)
          params[:product][:color_id]=c
          params[:product][:size_id]=s
          success_aux=Product.create params[:product]
          success=false if !success_aux
        end
      end
    end

    respond_to do |format|
      if success
        format.html { redirect_to(new_product_path, :notice => 'Articulo actualizado exitosamente!') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @products = Product.find_all_by_reference(@product.reference)
    Product.destroy @products

    redirect_to(products_url, :notice => 'Articulo borrado exitosamente!')
  end

  def search_size_color old_product, size_ids, color_ids
    ret_val=false
    size_ids.values.each do |size|
      color_ids.values.each do |color|
        if old_product.color_id == color.to_i && old_product.size_id == size.to_i
          ret_val = [color.to_i, size.to_i]
        end
      end
    end
    ret_val
  end

#  def search_to_create old_products,size_ids,color_ids
#    ret_val=[]
#    old_products.each do |op|
#      size_ids.each do |s|
#        color_ids.each do |c|
#          if !size_ids.include? op.size_id && !color_ids.include? op.color_id
#            op.destroy
#          end
#          if old_products_s.include? s && old_products_c.include? c
#
#          end
#        end
#      end
#    end
#
#    ret_val
#  end
end
