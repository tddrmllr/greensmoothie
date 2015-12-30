module UpdateImage
  def self.included(base)
    base.instance_eval("after_filter :update_image, only: [:create, :update]")
    base.instance_eval("after_filter :cleanup_images, only: [:update]")
  end

  private

  def update_image
    @resource = instance_variable_get("@#{controller_name.singularize}")
    image = Image.where(token: params["#{controller_name.singularize}"][:image_token]).first
    image.update_attributes(imageable_id: @resource.id, imageable_type: @resource.class.name) if image
  end

  def cleanup_images
    @resource = instance_variable_get("@#{controller_name.singularize}")
    images = Image.where(imageable_id: @resource.id, imageable_type: @resource.class.name).order('created_at ASC')
    last = images.last
    images.each {|i| i.destroy unless i == last}
  end
end
