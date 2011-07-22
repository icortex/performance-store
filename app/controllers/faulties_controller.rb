class FaultiesController < MyApplicationController
  # GET /faulties
  # GET /faulties.xml
  def index
    @faulties = Faulty.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @faulties }
    end
  end

  # GET /faulties/1
  # GET /faulties/1.xml
  def show
    @faulty = Faulty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @faulty }
    end
  end

  # GET /faulties/new
  # GET /faulties/new.xml
  def new
    @faulty = Faulty.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @faulty }
    end
  end

  # GET /faulties/1/edit
  def edit
    @faulty = Faulty.find(params[:id])
  end

  # POST /faulties
  # POST /faulties.xml
  def create
    @faulty = Faulty.new(params[:faulty])

    respond_to do |format|
      if @faulty.save
        format.html { redirect_to(@faulty, :notice => 'Faulty was successfully created.') }
        format.xml { render :xml => @faulty, :status => :created, :location => @faulty }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @faulty.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /faulties/1
  # PUT /faulties/1.xml
  def update
    @faulty = Faulty.find(params[:id])

    respond_to do |format|
      if @faulty.update_attributes(params[:faulty])
        format.html { redirect_to(@faulty, :notice => 'Faulty was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @faulty.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /faulties/1
  # DELETE /faulties/1.xml
  def destroy
    @faulty = Faulty.find(params[:id])
    @faulty.destroy

    respond_to do |format|
      format.html { redirect_to(faulties_url) }
      format.xml { head :ok }
    end
  end
end
