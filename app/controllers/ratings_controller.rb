class RatingsController < ApplicationController

  def create
    binding.pry
    @rating = Rating.new(rating_params)
    @recipe = Recipe.find(params[:recipe_id])
    if !current_user.rating?(@recipe) && @rating.save
      @recipe.update_rating
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:user_id, :recipe_id, :rating)
  end
end