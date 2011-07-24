class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_a? Admin
      can :manage, :all
    elsif user.is_a? Seller
      can :manage, :all
      cannot :manage, [Report, Expense, Admin]
      cannot [:create, :update, :destroy], [Product, Stock]
    end
  end
end
