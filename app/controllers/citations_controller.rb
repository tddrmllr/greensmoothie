class CitationsController < ApplicationController

  def edit
    @citation = Citation.find(params[:id])
    @citation.flags += 1
    render 'layouts/modal'
  end

  def update
    @citation = Citation.find(params[:id])
    @citation.update_attributes(citation_params)
    flash.now[:notice] = "The citation was flagged. If it gets too many flags, we'll remove it."
    render 'layouts/flasher'
  end

  private

  def citation_params
    params.require(:citation).permit(:flags)
  end
end