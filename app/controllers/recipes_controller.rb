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
    find_or_create_ingredients
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
    find_or_create_ingredients
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
    params.require(:recipe).permit(:name, :description, :instructions, :user_id, measurements_attributes: [:amount, :unit, :ingredient_id, :id, :_destroy])
  end

  def find_or_create_ingredients
    params[:recipe][:measurements_attributes].each do |k,v|
      ingredient = Ingredient.find_or_create(v['ingredient']['name'].downcase)
      params[:recipe][:measurements_attributes][k]['ingredient_id'] = ingredient.id
    end
  end
end
