module UpdateImage
  def self.included(base)
    base.instance_eval("after_filter :update_image, only: [:create, :update]")
  end

  private

  def update_image
    @resource = instance_variable_get("@#{controller_name.singularize}")
    image = Image.where(token: params["#{controller_name.singularize}"][:image_token])
    if image.any?
      image.first.update_attributes(imageable_id: @resource.id, imageable_type: @resource.class.name)
    end
  end
end