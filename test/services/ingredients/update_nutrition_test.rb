require 'test_helper'

module Ingredients
  class UpdateNutritionTest < UnitTest
    test 'run' do
      scraper = UpdateNutrition.new(url: nutrition_info_html, ingredient: ingredients(:kale))
      scraper.run
    end
  end
end
