require 'test_helper'

class RatingTest < UnitTest
  attr_accessor :rating

  setup do
    @rating = ratings(:admin_kale_smoothie_rating)
  end

  test 'recipe' do
    assert_kind_of Recipe, rating.recipe
  end

  test 'user' do
    assert_kind_of User, rating.user
  end

  test 'updates rating on recipe after save' do
    rating.update_attributes(rating: 1)
    assert_equal 1, rating.recipe.rating
  end
end
