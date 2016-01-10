module IngredientsHelper
  def named_ingredient_path(ingredient)
    "/ingredients/#{ingredient.url_name}"
  end
end
