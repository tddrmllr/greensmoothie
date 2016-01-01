require 'test_helper'

class UserTest < UnitTest
  attr_accessor :user

  setup do
    @user = users(:normal_user)
  end

  test 'amdin? should return false if role is not Admin' do
    refute user.admin?
  end

  test 'amdin? should return true if role is Admin' do
    user.update_column(:role, Ability::ADMIN)
    assert user.admin?
  end

  test 'authentications' do
    assert_includes user.authentications, authentications(:normal_user_facebook)
  end

  test 'email_required? should be false if sign_in_count is 0' do
    user.update_column(:sign_in_count, 0)
    refute user.email_required?
  end

  test 'email_required? should be true if sign_in_count is more than 0' do
    user.update_column(:sign_in_count, 1)
    assert user.email_required?
  end

  test 'ratings' do
    assert_includes user.ratings, ratings(:normal_user_beet_smoothie_rating)
  end

  test 'recipes' do
    assert_includes user.recipes, recipes(:kale_smoothie)
  end
end
