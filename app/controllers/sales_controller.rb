class SalesController < ApplicationController

  autocomplete :person, :document_id, :display_value => :name_and_doc
  include SalesHelper

  # GET /sales
  # GET /sales.xml
  def index
    if params[:headquarter]
      hq=Headquarter.find_by_name params[:headquarter]
    else
      hq=Headquarter.find current_user.headquarter_id
      params[:headquarter] =hq.name
    end
    @sales = Sale.find_all_by_headquarter_id hq.id


    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @sales }
    end
  end

  # GET /sales/1
  # GET /sales/1.xml
  def show
    @sale = Sale.find(params[:id])
    if @sale.person
      @client = "#{@sale.person.name}, #{@sale.person.document_id}"
    else
      @client = ''
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @sale }
    end
  end

  # GET /sales/new
  # GET /sales/new.xml
  def new
    @sale = Sale.new
    @sale.sale_products.build
    @products='[]'
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @sale }
    end
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
    products = @sale.products.collect do |p|
      organize(Product.where("reference = ? ", p.reference))[0]
    end
    @products=products.to_json
  end

  # POST /sales
  # POST /sales.xml
  def create
    params[:sale][:headquarter_id]=current_user.headquarter.id
    set_ids params[:sale][:sale_products_attributes]
    @sale = Sale.new(params[:sale])

    respond_to do |format|
      if @sale.save
        format.html { redirect_to(@sale, :notice => 'Venta creada exitosamente!') }
        format.xml { render :xml => @sale, :status => :created, :location => @sale }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @sale.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /sales/1
  # PUT /sales/1.xml
  def update
    params[:sale][:headquarter_id]=current_user.headquarter.id
    set_ids params[:sale][:sale_products_attributes]
    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to(@sale, :notice => 'Venta actualizada exitosamente!') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.xml
  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml { head :ok }
    end
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

