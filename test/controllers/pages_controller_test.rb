require 'test_helper'

class PagesControllerTest < ControllerTest
  tests PagesController

  test 'contact' do
    get :contact
    assert_response :success
    assert_template :contact
  end

  test 'home' do
    get :home
    assert_response :success
    assert_template :home
  end

  test 'privacy' do
    get :privacy
    assert_response :success
    assert_template :privacy
  end

  test 'terms' do
    get :terms
    assert_response :success
    assert_template :terms
  end
end
