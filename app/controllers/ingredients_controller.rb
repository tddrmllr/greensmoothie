class IngredientsController < ApplicationController

  respond_to :js, :html

  include UpdateImage

  def index
    @ingredients = Ingredient.all
    if request.xhr?
      render json: @ingredients
    end
  end

  def new
    @ingredient = Ingredient.new(name: params[:name])
    @image = @ingredient.build_image
    @elem = params[:elem]
    respond_with(@ingredient) do |format|
      format.js {render 'layouts/new'}
      format.html {render 'form'}
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
    @image = @ingredient.image ||= @ingredient.build_image
    render 'form'
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @elem = params[:elem]
    if @ingredient.save
      respond_with(@ingredient) do |format|
        format.html {redirect_to @ingredient}
        format.js {render 'layouts/create'}
      end
    else
      respond_with(@ingredient) do |format|
        format.html {render 'form'}
        format.js {render 'layouts/errors'}
      end
    end
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    @nutrients = @ingredient.nutrients
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update_attributes(ingredient_params)
    flash[:notice] = "Ingredient was updated."
    redirect_to @ingredient
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :description, citations_attributes: [:source, :citable_type, :citable_id, :id, :_destroy])
  end
end
