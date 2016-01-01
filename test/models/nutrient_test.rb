require 'test_helper'

class NutrientTest < UnitTest
  attr_accessor :nutrient

  setup do
    @nutrient = nutrients(:carbs)
  end

  test 'ingredient_nutrients' do
    assert_includes nutrient.ingredient_nutrients, ingredient_nutrients(:kale_carbs)
  end

  test 'ingredients' do
    assert_includes nutrient.ingredients, ingredients(:kale)
  end

  test 'macronutrients' do
    assert_includes Nutrient.macronutrients, nutrients(:carbs)
  end

  test 'minerals' do
    assert_includes Nutrient.minerals, nutrients(:iron)
  end

  test 'vitamins' do
    assert_includes Nutrient.vitamins, nutrients(:vitamin_k)
  end

  test 'populate creates record for all vitamin constants' do
    Nutrient.populate
    Nutrient::VITAMINS.each do |name, usda_name|
      assert_includes Nutrient.vitamins, Nutrient.where(name: name, usda_name: usda_name).first
    end
  end

  test 'populate creates record for all mineral constants' do
    Nutrient.populate
    Nutrient::MINERALS.each do |name, symbol|
      assert_includes Nutrient.minerals, Nutrient.where(name: name, symbol: symbol).first
    end
  end

  test 'populate creates record for all macronutrient constants' do
    Nutrient.populate
    Nutrient::MACRONUTRIENTS.each do |name, usda_name|
      assert_includes Nutrient.macronutrients, Nutrient.where(name: name, usda_name: usda_name).first
    end
  end

  test 'populate updates nutrients with daily values' do
    Nutrient.populate
    Nutrient::DV.each do |name, dv|
      _nutrient = Nutrient.find_by_name(name)
      assert_equal _nutrient.daily_value_amount, dv['amount'].to_d
      assert_equal _nutrient.daily_value_unit, dv['unit']
    end
  end
end
