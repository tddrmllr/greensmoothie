require 'test_helper'
require 'open-uri'

module Nutrients
  class ScrapedInfoTest < UnitTest
    attr_accessor :info, :nutrient

    setup do
      @info = ScrapedInfo.new(Nokogiri::HTML(open(nutrition_info_html)))
      @nutrient = nutrients(:vitamin_k)
    end

    test 'amount' do
      assert_equal '112.8', info.amount(nutrient)
    end

    test 'has_nutrient?' do
      assert info.has_nutrient?(nutrient)
    end

    test 'serving_size' do
      assert_equal "1 \n  \tcup 1\" pieces, loosely packed\n  \t", info.serving_size
    end

    test 'unit' do
      assert_equal "µg", info.unit(nutrient)
    end

    test 'usda_name' do
      assert_equal "\n       \n     Basic Report: \n   \n        11233, Kale, raw\n   \n     \n      \n   \n   \n       ", info.usda_name
    end
  end
end
