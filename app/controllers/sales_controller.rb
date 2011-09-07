class SalesController < MyApplicationController

  include SalesHelper
  layout 'application',:except => [:payment]
  before_filter :set_seller_id, :only=>[:create,:update]

  def index
    if (current_user.is_a? Admin) || (current_user.is_a? SuperAdmin)
      if params[:headquarter]
        hq=Headquarter.find_by_name params[:headquarter]
      else
        hq=Headquarter.find current_user.headquarter_id
        params[:headquarter] = hq.name
      end
      @sales = Sale.find_all_by_headquarter_id hq.id
      @headquarter = "en #{params[:headquarter]}"
    else
      @sales = Sale.where("headquarter_id = ? and (separated = ? or seller_id = ?)", current_user.headquarter_id,true,"#{current_user.id}")
      @headquarter = "en #{current_user.headquarter.name}"
    end

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
    @person = Person.new
  end

  def edit
    @sale = Sale.find(params[:id])
    products = @sale.products.collect do |p|
      organize(Product.where("reference = ? ", p.reference))[0]
    end
    @products=products.to_json
    @person = Person.new
  end

  def payment
    @sale = Sale.find(params[:sale_id])
  end

  def create
    params[:sale][:headquarter_id]=current_user.headquarter_id
    set_ids params[:sale][:sale_products_attributes] if params[:sale][:sale_products_attributes]
    @sale = Sale.new(params[:sale])

    respond_to do |format|
      if @sale.save
        format.html { redirect_to(@sale, :notice => 'Venta creada exitosamente.') }
      else
        @person = Person.new
        format.html { render :action => "new" }
      end
    end
  end

  def update
    params[:sale][:headquarter_id]=current_user.headquarter_id
    set_ids params[:sale][:sale_products_attributes] if params[:sale][:sale_products_attributes]
    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to(@sale, :notice => 'Venta actualizada exitosamente.') }
      else
        @person = Person.new
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    redirect_to(:back, :notice => 'Venta borrada exitosamente.')
  end

  private
  def set_seller_id
    params[:sale][:seller_id]=current_user.id
  end
end

