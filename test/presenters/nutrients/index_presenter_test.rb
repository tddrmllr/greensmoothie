require 'test_helper'

module Nutrients
  class IndexPresenterTest < ViewTest
    attr_accessor :presenter

    setup do
      @presenter = IndexPresenter.new(params: { controller: 'nutrients' })
    end

    test 'search_terms should equal :name_or_description_cont' do
      assert_equal :name_or_description_cont, presenter.search_terms
    end

    test 'title should be Nutrients' do
      assert_equal 'Nutrients', presenter.title
    end
  end
end
