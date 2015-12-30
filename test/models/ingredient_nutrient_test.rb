require 'test_helper'

class IngredientNutrientTest < UnitTest
  attr_accessor :ingredient_nutrient

  setup do
    @ingredient_nutrient = ingredient_nutrients(:kale_carbs)
  end

  test 'daily_percent' do
    assert_equal 300, ingredient_nutrient.daily_percent
  end

  test 'ingredient' do
    assert_kind_of Ingredient, ingredient_nutrient.ingredient
  end

  test 'macronutrients' do
    assert_includes IngredientNutrient.macronutrients, ingredient_nutrients(:kale_carbs)
  end

  test 'minerals' do
    assert_includes IngredientNutrient.minerals, ingredient_nutrients(:kale_iron)
  end

  test 'name' do
    assert_equal 'Carbohydrates', ingredient_nutrient.name
  end

  test 'nutrient' do
    assert_kind_of Nutrient, ingredient_nutrient.nutrient
  end

  test 'vitamins' do
    assert_includes IngredientNutrient.vitamins, ingredient_nutrients(:kale_vitamin_k)
  end
end
