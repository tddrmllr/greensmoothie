require 'test_helper'

class IngredientsControllerTest < ControllerTest
  tests IngredientsController

  attr_accessor :ingredient

  setup do
    @ingredient = ingredients(:kale)
  end

  class NoUser < IngredientsControllerTest
    test 'create' do
      post :create
      assert_response :forbidden
    end

    test 'destroy' do
      xhr :delete, :destroy, id: ingredient.id
      assert_response :forbidden
    end

    test 'edit' do
      get :edit, id: ingredient.id
      assert_response :forbidden
    end

    test 'index' do
      get :index
      assert_response :success
      assert_template :index
    end

    test 'new' do
      get :new
      assert_response :forbidden
    end

    test 'show should work with ingredient id route' do
      get :show, id: ingredient.id
      assert_response :success
      assert_template :show
    end

    test 'show should work with ingredient url_name route' do
      get :show, id: ingredient.url_name
      assert_response :success
      assert_template :show
    end

    test 'update' do
      put :update, id: ingredient.id
      assert_response :forbidden
    end
  end

  class NormalUser < IngredientsControllerTest
    setup do
      sign_in users(:normal_user)
    end

    test 'successful create' do
      post :create, ingredient: { name: 'Lettuce' }
      assert_redirected_to assigns(:ingredient)
    end

    test 'failed create' do
      post :create, ingredient: { name: nil }
      assert_template :form
    end

    test 'destroy' do
      xhr :delete, :destroy, id: ingredient.id
      assert_response :forbidden
    end

    test 'edit' do
      get :edit, id: ingredient.id
      assert_response :success
      assert_template :form
    end

    test 'new' do
      get :new
      assert_response :success
      assert_template :form
    end

    test 'show' do
      get :show, id: ingredient.id
      assert_response :success
      assert_template :show
    end

    test 'successful update' do
      put :update, id: ingredient.id, ingredient: { name: 'Not kale' }
      assert_redirected_to ingredient
      assert_equal 'Not kale', ingredient.reload.name
    end

    test 'failed update' do
      put :update, id: ingredient.id, ingredient: { name: nil }
      assert_template :form, partial: 'layouts/_errors'
    end
  end

  class AdminUser < IngredientsControllerTest
    setup do
      sign_in users(:admin_user)
    end

    test 'destroy' do
      xhr :delete, :destroy, id: ingredient.id
      assert_template 'layouts/destroy'
      refute Ingredient.exists?(ingredient)
    end
  end
end
