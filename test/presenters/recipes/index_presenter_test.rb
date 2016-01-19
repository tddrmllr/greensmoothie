require 'test_helper'

module Recipes
  class IndexPresenterTest < ViewTest
    attr_accessor :presenter

    setup do
      @presenter = IndexPresenter.new(params: { controller: 'recipes' })
    end

    test 'search_terms should equal :name_or_description_cont' do
      assert_equal :name_or_description_or_ingredients_name_cont, presenter.search_terms
    end

    test 'title should be Green Smoothie Recipes' do
      assert_equal 'Green Smoothie Recipes', presenter.title
    end
  end
end
