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
    find_or_create_nutrients
    if @ingredient.save
      redirect_to @ingredient
    else
      render 'form'
    end
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    @nutrients = @ingredient.nutrients
    @title = @ingredient.name
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    find_or_create_nutrients
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

  def find_or_create_nutrients
    params[:ingredient][:citations_attributes].each do |k,v|
      nutrient = Nutrient.find_or_create(v['nutrient']['name'].downcase)
      params[:ingredient][:citations_attributes][k]['citable_id'] = nutrient.id
    end
  end
end
