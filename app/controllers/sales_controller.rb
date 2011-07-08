class SalesController < ApplicationController

  autocomplete :person, :document_id, :full => true


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
      format.xml  { render :xml => @sales }
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
      format.xml  { render :xml => @sale }
    end
  end

  # GET /sales/new
  # GET /sales/new.xml
  def new
    @sale = Sale.new
    @sale.sale_products.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sale }
    end
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
    if @sale.person
      @client = "#{@sale.person.name}, #{@sale.person.document_id}"
    else
      @client = ''
    end

  end

  # POST /sales
  # POST /sales.xml
  def create
    params[:sale][:headquarter] = params[:sale][:headquarter] ?  Headquarter.find(params[:sale][:headquarter]) :
        Headquarter.find(current_user.headquarter_id)
    params[:sale][:person] = Person.find_by_document_id params[:sale][:person_id]
    if !params[:sale][:person]
      params[:sale][:person]=Person.create :document_id => params[:sale][:person_id]
    end

    @sale = Sale.new(params[:sale])

    respond_to do |format|
      if @sale.save
        format.html { redirect_to(@sale, :notice => 'Sale was successfully created.') }
        format.xml  { render :xml => @sale, :status => :created, :location => @sale }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sales/1
  # PUT /sales/1.xml
  def update
    params[:sale][:headquarter] = params[:sale][:headquarter] ?  Headquarter.find(params[:sale][:headquarter]) :
        Headquarter.find(current_user.headquarter_id)
    params[:sale][:person] = Person.find_by_document_id params[:sale][:person_id]
    if !params[:sale][:person]
      params[:sale][:person]=Person.create :document_id => params[:sale][:person_id]
    end

    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to(@sale, :notice => 'Sale was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sale.errors, :status => :unprocessable_entity }
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
      format.xml  { head :ok }
    end
  end

end
