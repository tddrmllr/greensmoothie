require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  attr_accessor :ingredient

  setup do
    @ingredient = ingredients(:kale)
  end

  test 'create should update nutrition info' do
    Nutrient.populate
    _ingredient = Ingredient.create(name: 'Purple Kale', source_url: nutrition_info_html.to_s)
    assert_equal 27, _ingredient.ingredient_nutrients.count
  end

  test 'find_or_create creates new if does not exist' do
    Ingredients::UpdateNutrition.stub :run, true do
      record = Ingredient.find_or_create('Foo seeds')
      assert record.persisted?
      assert_equal 'Foo seeds', record.name
    end
  end

  test 'find_or_create returns existing record if exists' do
    Ingredients::UpdateNutrition.stub :run, true do
      record = Ingredient.find_or_create('Kale')
      assert_equal ingredients(:kale), record
    end
  end

  test 'ingredient_nutrients' do
    assert_includes ingredient.ingredient_nutrients, ingredient_nutrients(:kale_carbs)
  end

  test 'macronutrients' do
    assert_includes ingredient.macronutrients, ingredient_nutrients(:kale_carbs)
  end

  test 'measurements' do
    assert_includes ingredient.measurements, measurements(:kale_smoothie_kale)
  end

  test 'minerals' do
    assert_includes ingredient.minerals, ingredient_nutrients(:kale_iron)
  end

  test 'nutrients' do
    assert_includes ingredient.nutrients, nutrients(:carbs)
  end

  test 'recipes' do
    assert_includes ingredient.recipes, recipes(:kale_smoothie)
  end

  test 'save deletes ingredient_nutrients if source_url is blank' do
    ingredient.update_attributes(source_url: nil)
    refute ingredient.ingredient_nutrients.any?
  end

  test 'save should update nutrition info if source_url changes' do
    Nutrient.populate
    ingredient.update_attributes(source_url: nutrition_info_html.to_s)
    assert_equal 27, ingredient.ingredient_nutrients.count
  end

  test 'vitamins' do
    assert_includes ingredient.vitamins, ingredient_nutrients(:kale_vitamin_k)
  end
end
