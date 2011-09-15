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
  end

  def edit
    @lot = Lot.find(params[:id])


  end

  def create
    set_ids params[:lot][:lot_products_attributes] if params[:lot][:lot_products_attributes]
    @lot = Lot.new(params[:lot])

    respond_to do |format|
      if @lot.save
        format.html { redirect_to(lots_path, :notice => 'Lote creado exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    set_ids params[:lot][:lot_products_attributes] if params[:lot][:lot_products_attributes]
    @lot = Lot.find(params[:id])

    respond_to do |format|
      if @lot.update_attributes(params[:lot])
        format.html { redirect_to(lots_path, :notice => 'Lote actualizado exitosamente.') }
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

  private

#[{:reference => 'perro', :brand => 'Adidas',  :sizes => {'s' =>{'am'=>[1,20]}, 'm'=> {'ne'=>[21,2]}}}, {}]
  def organize products
    ret=[]
    products.collect do |p|
      pr={}
      pr[:reference]=p.reference
      pr[:brand]=p.brand.brand
      pr[:sizes]={}
      sizes=p.available_sizes
      sizes.each do |s|
        pr[:sizes][s]={}

      end

    end
    ret
  end

end
