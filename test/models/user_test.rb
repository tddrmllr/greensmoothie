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

  test 'apply_omniauth builds an authentication with correct atts' do
    authentication = user.apply_omniauth(auth)
    assert_kind_of Authentication, authentication
    assert_equal provider, authentication.provider
    assert_equal auth_id, authentication.uid
  end

  test 'apply_omniauth sets user email if blank' do
    user.email = nil
    user.apply_omniauth(auth)
    assert_equal test_email, user.email
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

  test 'has_authentication_for? returns true if authentication found for provider' do
    assert user.has_authentication_for?(:facebook)
  end

  test 'has_authentication_for? returns false if no authentication found for provider' do
    refute user.has_authentication_for?(:twitter)
  end

  test 'has_rated? returns true if user rating found for recipe' do
    assert user.has_rated?(recipes(:beet_smoothie))
  end

  test 'has_rated? returns fale if no user rating found for recipe' do
    refute user.has_rated?(recipes(:kale_smoothie))
  end

  test 'password_required? returns true if user has no authentications when trying to sign_in' do
    user.password = 'password'
    user.authentications.destroy_all
    assert user.password_required?
  end

  test 'password_required? returns false if user has authentications' do
    refute user.password_required?
  end

  test 'ratings' do
    assert_includes user.ratings, ratings(:normal_user_beet_smoothie_rating)
  end

  test 'recipes' do
    assert_includes user.recipes, recipes(:kale_smoothie)
  end

  private

  def auth
    OpenStruct.new(info: auth_info, provider: provider, id: auth_id)
  end

  def auth_id
    'some_id'
  end

  def auth_info
    OpenStruct.new(email: test_email)
  end

  def provider
    'facebook'
  end

  def test_email
    'test@email.com'
  end
end
