class NutrientsController < ApplicationController

  respond_to :js, :html
  authorize_resource

  include Searchable

  def index
    @title = "Nutrients"
  end

  def new
    @nutrient = Nutrient.new(name: params[:name])
    @elem = params[:elem]
    @title = "New Nutrient"
    respond_with(@nutrient) do |format|
      format.js {render 'layouts/new'}
      format.html {render 'form'}
    end
  end

  def edit
    @nutrient = Nutrient.find(params[:id])
    @title = "Edit Nutrient"
    render 'form'
  end

  def create
    @nutrient = Nutrient.new(nutrient_params)
    @elem = params[:elem]
    if @nutrient.save
      respond_with(@nutrient) do |format|
        format.html {redirect_to @nutrient}
        format.js {render 'layouts/create'}
      end
    else
      respond_with(@nutrient) do |format|
        format.html {render 'form'}
        format.js {render 'layouts/errors'}
      end
    end
  end

  def show
    @nutrient = Nutrient.find(params[:id])
    @ingredients = @nutrient.ingredients
    @title = @nutrient.name
  end

  def update
    @nutrient = Nutrient.find(params[:id])
    if @nutrient.update_attributes(nutrient_params)
      flash[:success] = "Nutrient updated"
      redirect_to @nutrient
    else
      render 'form'
    end
  end

  private

  def nutrient_params
    params.require(:nutrient).permit(:name, :description, :symbol, benefits_attributes: [:name, :id, :description, :_destroy,  citation_attributes: [:citer_id, :citer_type, :citable_id, :citable_type, :_destroy, :id, :source]])
  end

end
