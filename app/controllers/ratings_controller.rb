class RatingsController < ApplicationController

  def create
    @recipe = Rating.create(recipe_id: params[:recipe_id], rating: params[:rating], user_id: current_user.id).recipe
  end

  private

  def rating_params
    params.require(:rating).permit(:user_id, :recipe_id, :rating)
  end
end
