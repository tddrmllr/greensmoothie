class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.role == "General"
      can :read, :all
      can :manage, [Nutrient, Ingredient]
      can :manage, Recipe, user_id: user.id
    else
      can :read, :all
    end
  end
end
