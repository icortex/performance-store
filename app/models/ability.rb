class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_a? SuperAdmin
      can :manage, :all
    elsif user.is_a? Admin
      can :manage, :all
      cannot :see, 'users'
      cannot :validate, User
    elsif user.is_a? Seller
      can :manage, :all
      cannot :manage, [Report, Expense, Admin, Lot]
      cannot [:create, :update, :destroy], [Product, Stock]
      cannot :destroy, [Person]
      cannot :see, 'hq_links'
      
    end
  end
end
