module IngredientsHelper
  def named_ingredient_path(ingredient)
    "/ingredients/#{ingredient.name.downcase}"
  end
end
