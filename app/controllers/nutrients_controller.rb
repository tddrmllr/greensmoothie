class NutrientsController < ApplicationController

  respond_to :js, :html
  authorize_resource

  def index
    @nutrients = Nutrients::IndexPresenter.new(params: params)
    respond_to do |format|
      format.js { render 'shared/index' }
      format.html
    end
  end

  def edit
    @nutrient = Nutrient.find(params[:id])
    @title = "Edit Nutrient"
    render 'form'
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
