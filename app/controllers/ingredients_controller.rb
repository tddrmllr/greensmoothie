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

  def show
    @ingredient = Ingredient.find(params[:id])
    @title = @ingredient.name
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update_attributes(ingredient_params)
      flash[:success] = "Ingredient was updated."
      redirect_to @ingredient
    else
      render 'form'
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :description, :source_url)
  end

  def find_or_create_nutrients
    params[:ingredient][:citations_attributes].each do |k,v|
      nutrient = Nutrient.find_or_create(v['nutrient']['name'].downcase)
      params[:ingredient][:citations_attributes][k]['citable_id'] = nutrient.id
    end
  end
end
