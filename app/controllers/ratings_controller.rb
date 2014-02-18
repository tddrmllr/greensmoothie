class RatingsController < ApplicationController

  def create
    @rating = Rating.new(recipe_id: params[:recipe_id], rating: params[:rating], user_id: current_user.id)
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