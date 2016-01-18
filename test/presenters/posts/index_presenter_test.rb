require 'test_helper'

module Posts
  class IndexPresenterTest < ViewTest
    attr_accessor :presenter

    setup do
      @presenter = IndexPresenter.new(params: { controller: 'posts' })
    end

    test 'search_terms should equal :name_or_description_cont' do
      assert_equal :name_or_body_or_description_cont, presenter.search_terms
    end

    test 'title should be The Green Smoothie Blog' do
      assert_equal 'The Green Smoothie Blog', presenter.title
    end
  end
end
