require 'test_helper'

class RatingsControllerTest < ControllerTest
  tests RatingsController

  test 'create' do
    sign_in users(:normal_user)
    recipe = recipes(:kale_smoothie)
    xhr :post, :create, recipe_id: recipe.id, rating: 5
    assert_response :success
    assert_template :create, partial: 'ratings/_rating'
  end
end
