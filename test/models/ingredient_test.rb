require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  attr_accessor :ingredient

  setup do
    @ingredient = ingredients(:kale)
  end

  test 'find_or_initialize initializes new if does not exist' do
    Ingredients::UpdateNutrition.stub :run, true do
      record = Ingredient.find_or_initialize('Foo seeds')
      refute_predicate record, :persisted?
      assert_equal 'Foo seeds', record.name
    end
  end

  test 'find_or_initialize returns existing record if exists' do
    Ingredients::UpdateNutrition.stub :run, true do
      record = Ingredient.find_or_initialize('Kale')
      assert_equal ingredients(:kale), record
      assert_predicate record, :persisted?
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

  test 'instructions should be set to blank string if only contains empty <p>' do
    ingredient.description = "<p><br></p>"
    ingredient.save
    assert_equal '', ingredient.description
  end

  test 'sets url_name on save' do
    ingredient.update_attributes(name: 'Super kale')
    assert_equal 'super-kale', ingredient.url_name
  end

  test 'vitamins' do
    assert_includes ingredient.vitamins, ingredient_nutrients(:kale_vitamin_k)
  end
end
