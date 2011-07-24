class SalesController < MyApplicationController

  autocomplete :person, :document_id, :display_value => :name_and_doc
  include SalesHelper

  def index
    if params[:headquarter]
      hq=Headquarter.find_by_name params[:headquarter]
    else
      hq=Headquarter.find current_user.headquarter_id
      params[:headquarter] =hq.name
    end
    @sales = Sale.find_all_by_headquarter_id hq.id
  end

  def show
    @sale = Sale.find(params[:id])
    if @sale.person
      @client = "#{@sale.person.name}, #{@sale.person.document_id}"
    else
      @client = ''
    end
  end

  def new
    @sale = Sale.new
    @sale.sale_products.build
    @products='[]'
  end

  def edit
    @sale = Sale.find(params[:id])
    products = @sale.products.collect do |p|
      organize(Product.where("reference = ? ", p.reference))[0]
    end
    @products=products.to_json
  end

  def create
    params[:sale][:headquarter_id]=current_user.headquarter.id
    set_ids params[:sale][:sale_products_attributes] if params[:sale][:sale_products_attributes]
    @sale = Sale.new(params[:sale])

    respond_to do |format|
      if @sale.save
        format.html { redirect_to(@sale, :notice => 'Venta creada exitosamente!') }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    params[:sale][:headquarter_id]=current_user.headquarter.id
    set_ids params[:sale][:sale_products_attributes] if params[:sale][:sale_products_attributes]
    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to(@sale, :notice => 'Venta actualizada exitosamente!') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    redirect_to(:back)
  end

  def set_ids sale_products
    sale_products.each do |k, sp|
      size= Size.find_by_size sp[:size]
      color = Color.find_by_color sp[:color]
      if !size.nil?
        p= Product.where("reference = ? and size_id = ? and color_id = ?", sp[:reference], size.id, color.id)[0]
        sp[:product_id] = p.id
      end
    end
  end
end

