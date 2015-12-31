require 'test_helper'

module Nutrients
  class MissingInfoTest < UnitTest
    attr_accessor :info, :nutrient

    setup do
      @info = MissingInfo.new
      @nutrient = nutrients(:carbs)
    end

    test 'amount' do
      assert_nil info.amount(nutrient)
    end

    test 'has_nutrient?' do
      refute info.has_nutrient?(nutrient)
    end

    test 'serving_size' do
      assert_nil info.serving_size
    end

    test 'unit' do
      assert_nil info.unit(nutrient)
    end

    test 'usda_name' do
      assert_nil info.usda_name
    end
  end
end
