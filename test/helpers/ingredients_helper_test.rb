require 'test_helper'

class IngredientsHelperTest < UnitTest
  include IngredientsHelper

  test 'named_ingredient_path' do
    ingredient = ingredients(:kale)
    assert_equal '/ingredients/kale', named_ingredient_path(ingredient)
  end
end
