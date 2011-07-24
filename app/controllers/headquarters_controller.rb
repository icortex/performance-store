class HeadquartersController < MyApplicationController

  layout 'application', :except=>['new', 'edit']

  def index
    @headquarters = Headquarter.all
  end

  def new
    @headquarter = Headquarter.new
  end

  def edit
    @headquarter = Headquarter.find(params[:id])
  end

  def create
    @headquarter = Headquarter.new(params[:headquarter])

    respond_to do |format|
      if @headquarter.save
        format.html { redirect_to(:back, :notice => 'Sede creada exitosamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @headquarter = Headquarter.find(params[:id])

    respond_to do |format|
      if @headquarter.update_attributes(params[:headquarter])
        format.html { redirect_to(admin_index_path, :notice => 'Sede actualizada exitosamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @headquarter = Headquarter.find(params[:id])
    @headquarter.destroy

    redirect_to(:back, :notice => 'Sede borrada exitosamente.')
  end
end
