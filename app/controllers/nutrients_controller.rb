class NutrientsController < ApplicationController

  respond_to :js, :html

  def index
    @nutrients = Nutrient.all
    if request.xhr?
      render json: @nutrients
    end
  end

  def new
    @nutrient = Nutrient.new(name: params[:name])
    @elem = params[:elem]
    respond_with(@nutrient) do |format|
      format.js {render 'layouts/new'}
      format.html {render 'form'}
    end
  end

  def edit
    @nutrient = Nutrient.find(params[:id])
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
  end

  def update
    @nutrient = Nutrient.find(params[:id])
    if @nutrient.update_attributes(nutrient_params)
      flash[:notice] = "Nutrient updated"
      redirect_to @nutrient
    else
      render 'form'
    end
  end

  private

  def nutrient_params
    params.require(:nutrient).permit(:name, :description, benefits_attributes: [:name, :id, :description, :_destroy,  citation_attributes: [:citer_id, :citer_type, :citable_id, :citable_type, :_destroy, :id, :source]])
  end

end
