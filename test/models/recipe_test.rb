require 'test_helper'

class RecipeTest < UnitTest
  attr_accessor :recipe

  setup do
    @recipe = recipes(:kale_smoothie)
  end

  test 'measurements' do
    assert_includes recipe.measurements, measurements(:kale_smoothie_kale)
  end

  test 'named_route' do
    assert_equal "/recipes/#{recipe.id}/kale-smoothie", recipe.named_route
  end

  test 'ingredients' do
    assert_includes recipe.ingredients, ingredients(:kale)
  end

  test 'ratings' do
    assert_includes recipe.ratings, ratings(:admin_user_kale_smoothie_rating)
  end

  test 'sets url_name on save' do
    recipe.update_attributes(name: 'Foo Recipe')
    assert_equal 'foo-recipe', recipe.url_name
  end

  test 'update_rating should calculate average of all ratings' do
    recipe.ratings.destroy_all
    recipe.ratings.create(rating: 3)
    recipe.ratings.create(rating: 5)
    recipe.update_column :rating, nil
    recipe.update_rating
    assert_equal (8/2).to_d, recipe.rating
  end

  test 'user' do
    assert_kind_of User, recipe.user
  end
end
