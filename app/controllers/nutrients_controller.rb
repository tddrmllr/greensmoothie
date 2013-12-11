class NutrientsController < ApplicationController

  def index
    @nutrients = Nutrient.all
    if request.xhr?
      render json: @nutrients
    end
  end

  def new
    @nutrient = Nutrient.new
    @citations = @nutrient.citations
    render 'form'
  end

  def edit
    @nutrient = Nutrient.find(params[:id])
    @citations = @nutrient.citations
    render 'form'
  end

  def create
    @nutrient = Nutrient.new(nutrient_params)
    if @nutrient.save
      redirect_to @nutrient
    end
  end

  def show
    @nutrient = Nutrient.find(params[:id])
  end

  def update
    @nutrient = Nutrient.find(params[:id])
    if @nutrient.update_attributes(nutrient_params)
      flash[:notice] = "Nutrient updated"
      redirect_to @nutrient
    else
      raise 'heck'
    end
  end

  private

  def nutrient_params
    params.require(:nutrient).permit(:name, :description, benefits_attributes: [:name, :id, :description, :_destroy,  citation_attributes: [:citer_id, :citer_type, :citable_id, :citable_type, :_destroy, :id, :source]])
  end

end
