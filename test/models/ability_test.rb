require 'test_helper'

class AbilityTest < UnitTest
  class AdminUser < UnitTest
    attr_accessor :ability

    setup do
      @ability = Ability.new(users(:admin_user))
    end

    test 'can manage posts' do
      assert ability.can? :manage, posts(:published_post)
    end
  end

  class NormalUser < UnitTest
    attr_accessor :ability, :user

    setup do
      @user = users(:normal_user)
      @ability = Ability.new(@user)
    end

    # nutrient privelages
    test 'can update a nutrient' do
      assert ability.can? :update, nutrients(:carbs)
    end

    test 'can edit a nutrient' do
      assert ability.can? :edit, nutrients(:carbs)
    end

    test 'can read a nutrient' do
      assert ability.can? :read, nutrients(:carbs)
    end

    test 'cannot create a nutrient' do
      refute ability.can? :create, Nutrient
    end

    test 'cannot destroy a nutrient' do
      refute ability.can? :destroy, nutrients(:carbs)
    end

    # ingredient privelages
    test 'can update an ingredient' do
      assert ability.can? :update, ingredients(:kale)
    end

    test 'can edit an ingredient' do
      assert ability.can? :edit, ingredients(:kale)
    end

    test 'can read an ingredient' do
      assert ability.can? :read, ingredients(:kale)
    end

    test 'can create an ingredient' do
      assert ability.can? :create, Ingredient
    end

    test 'cannot destroy an ingredient' do
      refute ability.can? :destroy, ingredients(:kale)
    end

    # recipe privelages
    test 'can update a recipe they created' do
      assert ability.can? :update, recipes(:kale_smoothie)
    end

    test 'cannot update a recipe they did not create' do
      refute ability.can? :update, recipes(:beet_smoothie)
    end

    test 'can edit a recipe they created' do
      assert ability.can? :edit, recipes(:kale_smoothie)
    end

    test 'cannot edit a recipe they did not create' do
      refute ability.can? :edit, recipes(:beet_smoothie)
    end

    test 'can read a recipe' do
      assert ability.can? :read, recipes(:beet_smoothie)
    end

    test 'can create a recipe' do
      assert ability.can? :create, Recipe
    end

    test 'can destroy a recipe they created' do
      assert ability.can? :destroy, recipes(:kale_smoothie)
    end

    test 'cannot destroy a recipe they did create' do
      refute ability.can? :destroy, recipes(:beet_smoothie)
    end

    # user privelages
    test 'can update their account' do
      assert ability.can? :update, users(:normal_user)
    end

    test 'cannot update another account' do
      refute ability.can? :update, users(:admin_user)
    end

    test 'can edit their account' do
      assert ability.can? :edit, users(:normal_user)
    end

    test 'cannot edit another account' do
      refute ability.can? :edit, users(:admin_user)
    end

    test 'can destroy their account' do
      assert ability.can? :destroy, users(:normal_user)
    end

    test 'cannot destroy another account' do
      refute ability.can? :destroy, users(:admin_user)
    end

    test 'can read their account' do
      assert ability.can? :read, users(:normal_user)
    end

    test 'can read another account' do
      assert ability.can? :read, users(:admin_user)
    end

    test 'cannot create a user' do
      refute ability.can? :create, User
    end

    # post privelages
    test 'cannot update a post' do
      refute ability.can? :update, posts(:published_post)
    end

    test 'cannot edit a post' do
      refute ability.can? :edit, posts(:published_post)
    end

    test 'can read a post' do
      assert ability.can? :read, posts(:published_post)
    end

    test 'cannot create a post' do
      refute ability.can? :create, Post
    end

    test 'cannot destroy a post' do
      refute ability.can? :destroy, posts(:published_post)
    end
  end

  class GuestUser < UnitTest
    attr_accessor :ability

    setup do
      @ability = Ability.new(nil)
    end

    test 'can read any post' do
      assert ability.can? :read, posts(:published_post)
    end

    test 'can read any recipe' do
      assert ability.can? :read, recipes(:kale_smoothie)
    end

    test 'can read any ingredient' do
      assert ability.can? :read, ingredients(:kale)
    end

    test 'can read any nutrient' do
      assert ability.can? :read, nutrients(:carbs)
    end

    test 'cannot manage any posts' do
      refute ability.can? :manage, posts(:published_post)
    end

    test 'cannot manage any users' do
      refute ability.can? :manage, users(:normal_user)
    end

    test 'cannot manage any ingredients' do
      refute ability.can? :manage, ingredients(:kale)
    end

    test 'cannot manage any nutrients' do
      refute ability.can? :manage, nutrients(:carbs)
    end
  end
end
