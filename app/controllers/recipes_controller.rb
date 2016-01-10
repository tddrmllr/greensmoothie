class RecipesController < ApplicationController

  authorize_resource

  include UpdateImage

  def index
    @search = Recipe.ransack(params[:q])
    @recipes = Kaminari.paginate_array(@search.result(distinct: true)).page(params[:page]).per(8)
    @title = "Green Smoothie Recipes"
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
    # find_by_id is for legacy urls
    @recipe = Recipe.find_by_url_name(params[:id]) || Recipe.find_by_id(params[:id])
    @ingredients = @recipe.ingredients
    @title = @recipe.name
    @delete = true
  end

  def update
    @recipe = Recipe.find(params[:id])
    find_or_create_ingredients
    if @recipe.update_attributes(recipe_params)
      redirect_to @recipe.named_route
      flash[:success] = "Recipe saved successfully."
    else
      @delete = true
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
