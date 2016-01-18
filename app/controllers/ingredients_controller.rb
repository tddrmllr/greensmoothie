class IngredientsController < ApplicationController

  respond_to :js, :html
  authorize_resource

  include UpdateImage

  def index
    @ingredients = Ingredients::IndexPresenter.new(params: params)
    respond_to do |format|
      format.js { render 'shared/index' }
      format.html
    end
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
    @ingredient = Ingredient.find_by_url_name(params[:id]) || Ingredient.find_by_id(params[:id])
    @title = @ingredient.name
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update_attributes(ingredient_params)
      flash[:success] = "Ingredient was updated."
      redirect_to @ingredient
    else
      flash[:error] = @ingredient.errors.full_messages.join(', ')
      render 'form'
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :description, :source_url)
  end
end
