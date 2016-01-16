require 'test_helper'

module Recipes
  class ShowPresenterTest < ViewTest
    test 'title should return recipe name' do
      recipe = recipes(:kale_smoothie)
      presenter = ShowPresenter.new(id: recipe.url_name, view_context: view)
      assert_equal 'Kale Smoothie', presenter.title
    end
  end
end
