class RecipesController < ApplicationController

  authorize_resource

  include UpdateImage

  def index
    @recipes = Recipes::IndexPresenter.new(params: params, per: 8)
  end

  def new
    @recipe = Recipe.new
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
    @recipe = Recipes::ShowPresenter.new(id: params[:id], view_context: view_context)
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      redirect_to @recipe.named_route
      flash[:success] = "Recipe saved successfully."
    else
      render 'form'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    authorize! :manage, @recipe
    @recipe.destroy
    flash[:success] = "Recipe deleted."
    @redirect = recipes_path
    render 'layouts/destroy'
  end

  private

  def recipe_params
    # the measurements_attributes needs to have the :id attr to prevent duplicate objects getting created
    params.require(:recipe).permit(:name, :description, :instructions, :user_id, measurements_attributes: [:amount, :unit, :ingredient_id, :ingredient_name, :id, :_destroy])
  end
end
