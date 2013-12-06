class IngredientsController < ApplicationController

  include UpdateImage

  def index
    @ingredients = Ingredient.all
    if request.xhr?
      render json: @ingredients
    end
  end

  def new
    @ingredient = Ingredient.new
    @image = @ingredient.build_image
    @citations = @ingredient.citations
    render 'form'
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
    @image = @ingredient.image ||= @ingredient.build_image
    @citations = @ingredient.citations
    render 'form'
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to @ingredient
    else
      raise 'heck'
    end
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update_attributes(ingredient_params)
    flash[:notice] = "Ingredient was updated."
    redirect_to @ingredient
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :description, citations_attributes: [:source, :nutrient_id, :_destroy])
  end
end
