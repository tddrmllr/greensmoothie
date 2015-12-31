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
end
