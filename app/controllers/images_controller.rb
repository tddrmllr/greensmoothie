class ImagesController < ApplicationController

  def create
    @image = Image.new(image_params)
    if @image.save
      flash.now[:success] = "Photo updated successfully."
    else
      flash.now[:error] = "Invalid image or URL."
    end
  end

  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(image_params)
      if @image.cropping?
        @image.image.reprocess!
      end
      flash.now[:success] = "Photo updated successfully."
    else
      flash.now[:error] = "Invalid image or URL."
    end
  end

  def edit
    @image = Image.find(params[:id])
    render 'layouts/modal'
  end

  private

  def image_params
    params.require(:image).permit(:crop_x, :crop_y, :crop_h, :crop_w, :imageable_id, :imageable_type, :image, :token, :image_url)
  end

end
