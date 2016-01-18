require 'test_helper'

class NutrientsControllerTest < ControllerTest
  class NoUser < ControllerTest
    tests NutrientsController

    attr_accessor :nutrient

    setup do
      @nutrient = nutrients(:carbs)
    end

    test 'edit' do
      get :edit, id: nutrient.id
      assert_response :forbidden
    end

    test 'index html' do
      get :index
      assert_response :success
      assert_template :index
    end

    test 'index js' do
      xhr :get, :index
      assert_response :success
      assert_template 'shared/index'
    end

    test 'show' do
      get :show, id: nutrient.id
      assert_response :success
      assert_template :show
    end

    test 'update' do
      get :update, id: nutrient.id
      assert_response :forbidden
    end
  end

  class NormalUser < ControllerTest
    tests NutrientsController

    attr_accessor :nutrient

    setup do
      @nutrient = nutrients(:carbs)
      sign_in users(:normal_user)
    end

    test 'edit' do
      get :edit, id: nutrient.id
      assert_response :success
      assert_template :form
    end

    test 'index' do
      get :index
      assert_response :success
      assert_template :index
    end

    test 'show' do
      get :show, id: nutrient.id
      assert_response :success
      assert_template :show
    end

    test 'successful update' do
      get :update, id: nutrient.id, nutrient: { name: 'Carbs' }
      assert_redirected_to nutrient
    end

    test 'failed update' do
      get :update, id: nutrient.id, nutrient: { name: nil }
      assert_template :form
    end
  end
end
