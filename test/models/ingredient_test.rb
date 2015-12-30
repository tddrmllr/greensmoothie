require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  attr_accessor :ingredient

  setup do
    @ingredient = ingredients(:kale)
  end

  test 'find_or_create creates new if does not exist' do
    Nutrients::Scrape.stub :run, true do
      record = Ingredient.find_or_create('Foo seeds')
      assert record.persisted?
      assert_equal 'Foo seeds', record.name
    end
  end

  test 'find_or_create returns existing record if exists' do
    Nutrients::Scrape.stub :run, true do
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

  test 'vitamins' do
    assert_includes ingredient.vitamins, ingredient_nutrients(:kale_vitamin_k)
  end
end
