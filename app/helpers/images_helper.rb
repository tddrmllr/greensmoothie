module ImagesHelper
  def gradient_image(resource)
    content_tag :div, class: 'show-image', style: "background-image: url(#{large_image_path(resource)})" do
      image_tag 'white-transparent-gradient.png'
    end
  end

  def thumbnail_image_path(resource)
    if resource.image?
      resource.image.image.url(:thumb)
    else
      fallback_image_path(resource)
    end
  end

  private

  def fallback_image_path(resource)
    asset_path "#{resource.class.name.downcase}.png"
  end

  def large_image_path(resource)
    if resource.image?
      resource.image.image.url(:large)
    else
      fallback_image_path(resource)
    end
  end
end
