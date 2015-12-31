require 'test_helper'

module Ingredients
  class UpdateNutritionTest < UnitTest
    attr_accessor :ingredient, :scraper

    setup do
      @ingredient = ingredients(:kale)
      @scraper = UpdateNutrition.new(url: nutrition_info_html, ingredient: @ingredient)
      Nutrient.populate
    end

    test 'run' do
      scraper.run
      ingredient.reload
      assert_equal 27, ingredient.ingredient_nutrients.count
      assert_equal source_url, ingredient.source_url
      assert_equal usda_name, ingredient.usda_name
      assert_equal serving_size, ingredient.serving_size
    end

    private

    def serving_size
      "1 \n  \tcup 1\" pieces, loosely packed\n  \t"
    end

    def source_url
      "--- !ruby/object:Pathname\npath: \"/Users/toddmiller/Apps/greensmoothie/test/fixtures/files/kale_nutrition.html\"\n"
    end

    def usda_name
      "\n       \n     Basic Report: \n   \n        11233, Kale, raw\n   \n     \n      \n   \n   \n       "
    end
  end
end
