class Ability
  include CanCan::Ability

  ADMIN = 'Admin'

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.persisted?
      can :read, :all
      can [:create, :update, :edit], Ingredient
      can [:update, :edit], Nutrient
      can :manage, Recipe, user_id: user.id
      can [:update, :edit, :destroy], User, id: user.id
    else
      can :read, :all
    end
  end
end
