class LotsController < MyApplicationController
  include ApplicationHelper
  include ProductsHelper

  def index
    @lots = Lot.all
  end

  def show
    @lot = Lot.find(params[:id])
  end

  def new
    @lot = Lot.new
    @lot.lot_products.build
    @products='[]'
    @product=Product.new
  end

  def edit
    @lot = Lot.find(params[:id])
    products = @lot.products.collect do |p|
      organize(Product.where("reference = ? ", p.reference),false)[0]
    end
    @products=products.to_json
    @product=Product.new
  end

  def stock
    respond_to do |format|
      format.html{
        @lot = Lot.find(params[:id])
        products = @lot.products.collect do |p|
          organize(Product.where("reference = ? ", p.reference),false)[0]
        end
        @products=products.to_json
        @product=Product.new
      }
      format.js
    end

  end

  def create
    set_ids params[:lot][:lot_products_attributes] if params[:lot][:lot_products_attributes]
    @lot = Lot.new(params[:lot])

    respond_to do |format|
      if @lot.save
        format.html { redirect_to(edit_lot_path @lot.id) }
      else
        products=params[:lot][:lot_products_attributes].collect do|k,lp|
          Product.find(lp[:product_id])
        end
        products=products.collect do |p|
          organize(Product.find_all_by_reference(p.reference),false)[0]
        end
        @products=products.to_json

        format.html { render :action => "new" }
      end
    end
  end

  def update
    set_ids params[:lot][:lot_products_attributes] if params[:lot][:lot_products_attributes]
    @lot = Lot.find(params[:id])

    respond_to do |format|
      if @lot.update_attributes(params[:lot])
        format.html { redirect_to(:back, :notice => 'Lote guardado exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @lot = Lot.find(params[:id])
    @lot.destroy

    redirect_to(:back, :notice => 'Lote borrado exitosamente.')
  end
end
