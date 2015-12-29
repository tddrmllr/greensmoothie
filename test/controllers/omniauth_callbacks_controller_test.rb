require 'test_helper'

class OmniauthCallbacksControllerTest < ControllerTest
  tests OmniauthCallbacksController

  attr_accessor :user

  setup do
    @request.env['omniauth.auth'] = auth
    @request.env['omniauth.params'] = { redirect: 'girls_path' }.with_indifferent_access
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:normal_user)
  end

  test 'facebook signs in user and redirects if authentication found' do
    Authentication.stub :where, [authentications(:normal_user_facebook)] do
      get :facebook
      assert_redirected_to user_path(user)
      assert_equal "Signed in successfully.", flash.notice
    end
  end

  test 'facebook creates new authentication if user signed in and has no authentication' do
    prep_user
    get :facebook
    assert_redirected_to user_path(user)
    assert_equal "Authentication successful.", flash.notice
    assert_kind_of Authentication, user.reload.authentications.first
  end

  test 'facebook creates a new user and redirects to edit_user_path if new authentication successful' do
    User.stub :new, ValidUser.new do
      get :facebook
      assert_redirected_to edit_user_path(99, signup: true)
      assert_equal "Signed in successfully.", flash.notice
    end
  end

  test 'facebook redirects to new_user_registration_path if new authentication fails' do
    User.stub :new, InvalidUser.new do
      get :facebook
      assert_redirected_to new_user_session_path
      assert_equal "Unable to authenticate.", flash[:error]
    end
  end

  private

  def auth
    OpenStruct.new(credentials: auth_credentials, provider: 'facebook', id: 'some_id', uid: 'some_id', info: auth_info)
  end

  def auth_credentials
    OpenStruct.new(token: 'some_token')
  end

  def auth_info
    OpenStruct.new(email: 'test@email.com')
  end

  def prep_user
    sign_in user
    user.authentications.destroy_all
    user
  end

  class InvalidUser
    def apply_omniauth(arg)
      arg = false
    end

    def save
      false
    end
  end

  class ValidUser < User
    def apply_omniauth(arg)
      arg = true
    end

    def id
      99
    end

    def save(*args)
      true
    end

    def update_mailchimp_subscription
      false
    end
  end
end
