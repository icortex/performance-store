class AdminController < MyApplicationController

  def index
    @brands = Brand.all
    @headquarters = Headquarter.all
    @colors = Color.all
    @sizes = Size.all
    @cloth_types = ClothType.all
    @variables = Variable.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def validate
    @unvalidated_users = User.find_all_by_validated(false)
    @validated_users = User.find_all_by_validated(true)
  end

  def validation
    User.find(empty_hash_if_nil(params[:destroy]).keys).each do |user|
      user.destroy
    end

    User.find(empty_hash_if_nil(params[:validation]).keys).each do |user|
      p 'sssssssssssssssssssssssssssssss'
      p user
      user.validated = true
      user.headquarter_id = params[:headquarter_id][user.id.to_s].to_i
      user.type = params[:user][:type][user.id.to_s]
      user.save
    end
    

    redirect_to validate_users_path
  end

  def empty_hash_if_nil(arg)
    arg.nil? ? {} : arg
  end
end
