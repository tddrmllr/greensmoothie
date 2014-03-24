class IngredientsController < ApplicationController

  respond_to :js, :html
  authorize_resource

  include UpdateImage
  include Searchable

  def index
    @title = "Ingredients"
  end

  def list
    params[:search] = {name_cont: params[:q]}
    render json: Ingredient.search(params[:search]).result
  end

  def new
    @ingredient = Ingredient.new(name: params[:name])
    @elem = params[:elem]
    @title = "New Ingredient"
    respond_with(@ingredient) do |format|
      format.js {render 'layouts/new'}
      format.html {render 'form'}
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
    @title = "Edit Ingredient"
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
    @title = @ingredient.name
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update_attributes(ingredient_params)
      flash[:notice] = "Ingredient was updated."
      redirect_to @ingredient
    else
      render 'form'
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :description, citations_attributes: [:source, :citable_type, :citable_id, :id, :_destroy])
  end
end
