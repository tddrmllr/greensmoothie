require 'test_helper'

class UsersControllerTest < ControllerTest
  class NormalUser < ControllerTest
    tests UsersController

    attr_accessor :user

    setup do
      @user = users(:normal_user)
      sign_in @user
    end

    test 'can destroy own account' do
      xhr :delete, :destroy, id: user.id
      assert_equal 'Account deleted.', flash[:success]
      assert_template 'layouts/destroy'
    end

    test 'cannot destroy someone elses account' do
      xhr :delete, :destroy, id: users(:admin_user).id
      assert_response :forbidden
    end

    test 'can edit own account' do
      get :edit, id: user.id
      assert_response :success
    end

    test 'cannot edit someone elses account' do
      get :edit, id: users(:admin_user).id
      assert_response :forbidden
    end

    test 'show' do
      get :show, id: user.id
      assert_response :success
    end

    test 'successful update without password' do
      put :update, id: user.id, user: { username: 'foobar' }
      assert_redirected_to user
      assert_equal "Account updated.", flash[:success]
    end

    test 'successful update with password' do
      put :update, id: user.id, user: { password: 'foobar', password_confirmation: 'foobar' }
      assert_redirected_to user
      assert_equal "Account updated.", flash[:success]
    end

    test 'failed update' do
      put :update, id: user.id, user: { username: nil }
      assert_template :form, partial: 'layouts/_errors'
    end
  end
end
