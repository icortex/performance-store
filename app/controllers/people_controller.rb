class PeopleController < ApplicationController

  load_and_authorize_resource
  check_authorization

  # GET /people
  # GET /people.xml
  def index
    @people = Person.where('document_id like ?', "%#{params[:q]}%")
    case request.path
      when '/clientes'
        @title = 'Lista de clientes'
      when '/clientes/cumpleanos'
        from = Date.today.yday
        to = from + 7
        @people = []
        @emails = ''
        Person.all.each do |p|
          if(p.birthday.yday >= from && p.birthday.yday <= to)
            @people << p
            @emails += p.email + ', '
          end
        end
        @emails.chop!.chop!
        @title = 'Lista de cumpleaneros'
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @people }
      format.json { render :json => @people.map(&:attributes)}
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to(people_path, :notice => 'Cliente agregado exitosamente!') }
        format.xml { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(people_path, :notice => 'Cliente actualizado exitosamente!') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url , :notice => 'Cliente borrado exitosamente!') }
      format.xml { head :ok }
    end
  end

  def cumpleanos

  end

end
