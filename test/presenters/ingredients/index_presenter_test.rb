require 'test_helper'

module Ingredients
  class IndexPresenterTest < ViewTest
    attr_accessor :presenter

    setup do
      @presenter = IndexPresenter.new(params: { controller: 'ingredients' })
    end

    test 'search_terms should equal :name_or_description_or_nutrients_name_cont' do
      assert_equal :name_or_description_or_nutrients_name_cont, presenter.search_terms
    end

    test 'title should be Ingredients' do
      assert_equal 'Ingredients', presenter.title
    end
  end
end
