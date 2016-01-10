require 'test_helper'

class RecipesControllerTest < ControllerTest
  class NoUser < ControllerTest
    tests RecipesController

    attr_accessor :recipe

    setup do
      @recipe = recipes(:kale_smoothie)
    end

    test 'create' do
      post :create
      assert_response :forbidden
    end

    test 'destroy' do
      xhr :delete, :destroy, id: recipe.id
      assert_response :forbidden
    end

    test 'edit' do
      get :edit, id: recipe.id
      assert_response :forbidden
    end

    test 'index' do
      get :index
      assert_response :success
    end

    test 'show should render with id in url' do
      get :show, id: recipe.id
      assert_response :success
    end

    test 'show should render with url_name in url' do
      get :show, id: recipe.url_name
      assert_response :success
    end

    test 'update' do
      put :update, id: recipe.id
      assert_response :forbidden
    end
  end

  class NormalUser < ControllerTest
    tests RecipesController

    attr_accessor :recipe

    setup do
      @recipe = recipes(:kale_smoothie)
      sign_in users(:normal_user)
    end

    test 'successful create' do
      post :create, recipe: valid_recipe_params
      assert_redirected_to "#{HOST}#{assigns(:recipe).named_route}"
    end

    test 'falied create' do
      post :create, recipe: { name: nil, measurements_attributes: {} }
      assert_response 200
      assert_template :form
    end

    test 'can destroy own recipes' do
      xhr :delete, :destroy, id: recipe.id
      assert_template 'layouts/destroy'
      refute Recipe.exists?(recipe)
    end

    test 'cannot destroy others recipes' do
      xhr :delete, :destroy, id: recipes(:beet_smoothie).id
      assert_response :forbidden
    end

    test 'edit' do
      get :edit, id: recipe.id
      assert_response :success
    end

    test 'index' do
      get :index
      assert_response :success
    end

    test 'show' do
      get :show, id: recipe.id
      assert_response :success
    end

    test 'successful update' do
      put :update, id: recipe.id, recipe: { name: 'Foo Recipe', measurements_attributes: {} }
      assert_redirected_to "#{HOST}#{assigns(:recipe).named_route}"
      assert_equal "Recipe saved successfully.", flash[:success]
    end

    test 'failed update' do
      put :update, id: recipe.id, recipe: { name: nil, measurements_attributes: {} }
      assert_response 200
      assert_template :form, partial: 'layouts/_errors'
    end

    private

    def valid_recipe_params
      ingredient = ingredients(:beets)
      {
        name: 'Test Recipe',
        description: 'A yummy recipe',
        measurements_attributes: {
          '0' => {
            ingredient: {
              name: ingredient.name
            },
            ingredient_id: ingredient.id,
            amount: '1',
            unit: 'beet'
          }
        }
      }
    end
  end
end
