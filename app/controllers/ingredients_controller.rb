class IngredientsController < ApplicationController

  respond_to :js, :html
  authorize_resource

  include UpdateImage
  include Searchable

  def index
    @title = "Ingredients"
  end

  def new
    @ingredient = Ingredient.new(name: params[:name])
    @title = "New Ingredient"
    render 'form'
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
    @title = "Edit Ingredient"
    render 'form'
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = 'Ingredient successfully created.'
      redirect_to @ingredient
    else
      render 'form'
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    flash[:success] = 'Ingredient deleted.'
    @redirect = ingredients_path
    render 'layouts/destroy'
  end

  def show
    # find_by_id is to support legacy urls
    @ingredient = Ingredient.find_by_name(params[:id]) || Ingredient.find_by_id(params[:id])
    @title = @ingredient.name
    @delete = true
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update_attributes(ingredient_params)
      flash[:success] = "Ingredient was updated."
      redirect_to @ingredient
    else
      @delete = true
      flash[:error] = @ingredient.errors.full_messages.join(', ')
      render 'form'
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :description, :source_url)
  end
end
