class NutrientsController < ApplicationController

  def index
    @nutrients = Nutrient.all
    if request.xhr?
      render json: @nutrients
    end
  end

end
