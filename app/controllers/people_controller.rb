class PeopleController < MyApplicationController

  load_and_authorize_resource
  check_authorization

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
          if p.birthday
            if (p.birthday.yday >= from && p.birthday.yday <= to)
              @people << p
              @emails += p.email + ', '
            end
          end
        end
        @emails.chop!.chop! if !@emails.chop!.nil?

        @title = "Lista de cumpleaneros de la proxima semana"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @people.map(&:attributes) }
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to(:back, :notice => 'Cliente agregado exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(people_path, :notice => 'Cliente actualizado exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    redirect_to(:back, :notice => 'Cliente borrado exitosamente.')
  end
end
