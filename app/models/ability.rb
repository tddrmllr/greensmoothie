class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.persisted?
      can :read, :all
      can [:create, :update, :edit], [Nutrient, Ingredient]
      can :manage, Recipe, user_id: user.id
      can :manage, User, id: user.id
    else
      can :read, :all
    end
  end
end
