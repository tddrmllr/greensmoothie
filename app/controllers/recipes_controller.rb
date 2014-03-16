class RecipesController < ApplicationController

  authorize_resource

  include UpdateImage
  include UpdateTags

  def index
    @search = Recipe.search(params[:q])
    @recipes = Kaminari.paginate_array(@search.result(distinct: true)).page(params[:page]).per(8)
    @title = "Green Smoothie Recipes"
  end

  def new
    @recipe = Recipe.new(user_id: current_user.id)
    @measurements = @recipe.measurements
    @title = "New Recipe"
    render 'form'
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @measurements = @recipe.measurements
    @title = "Edit Recipe"
    render 'form'
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe.named_route
    else
      render 'form'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
    @comments = @recipe.comments
    @title = @recipe.name
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update_attributes(recipe_params)
    if @recipe.save
      redirect_to @recipe.named_route
      flash[:notice] = "Recipe saved successfully."
    else
      render 'form'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = "Recipe deleted."
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :instructions, :user_id, measurements_attributes: [:amount, :unit, :ingredient_id, :id, :_destroy])
  end
end
