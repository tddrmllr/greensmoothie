module ImagesHelper
  def media_object_url(resource)
    if resource.image?
      resource.image.image.url(:thumb)
    else
      asset_path "#{resource.class.name.downcase}.png"
    end
  end
end
