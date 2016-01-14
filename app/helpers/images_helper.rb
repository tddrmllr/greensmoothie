module ImagesHelper
  def gradient_image(resource)
    content_tag :div, class: 'show-image', style: "background-image: url(#{large_image_path(resource)})" do
      image_tag 'white-transparent-gradient.png'
    end
  end

  def large_image_path(resource)
    guaranteed_image_path(resource, :large)
  end

  def medium_image_path(resource)
    guaranteed_image_path(resource, :medium)
  end

  def thumbnail_image_path(resource)
    guaranteed_image_path(resource, :thumb)
  end

  private

  def guaranteed_image_path(resource, size = :medium)
    if resource.image?
      resource.image.image.url(size)
    else
      fallback_image_path(resource)
    end
  end

  def fallback_image_path(resource)
    asset_path "#{resource.class.name.downcase}.png"
  end
end
