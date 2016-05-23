require 'test_helper'

class MeasurementTest < UnitTest
  attr_accessor :measurement

  setup do
    @measurement = measurements(:kale_smoothie_kale)
  end

  test 'recipe' do
    assert_kind_of Recipe, measurement.recipe
  end

  test 'ingredient' do
    assert_kind_of Ingredient, measurement.ingredient
  end

  test 'ingredient_name' do
    assert_equal 'Kale', measurement.ingredient_name
  end

  test 'ingredient_name= sets ingredient_name' do
    measurement.ingredient_name = 'Foo'
    assert_equal 'Foo', measurement.ingredient_name
  end

  test 'ingredient_name= sets ingredient' do
    measurement.ingredient_name = 'Beets'
    assert_equal ingredients(:beets), measurement.ingredient
  end
end
