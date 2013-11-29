class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new(user_id: current_user.id)
    render 'form'
  end

  def edit
    @recipe = Recipe.find(params[:id])
    render 'form'
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render 'layouts/errors'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update_attributes(recipe_params)
    if @recipe.save
      if @recipe.cropping?
        @recipe.image.reprocess!
      end
      redirect_to @recipe
      flash[:notice] = "Recipe saved successfully."
    else
      render 'layouts/errors'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :instructions, :user_id, :image, :crop_x, :crop_y, :crop_h, :crop_w, measurements_attributes: [:amount, :unit, :ingredient_id, :id, :_destroy])
  end
end
