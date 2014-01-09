module ImagesHelper

  def thumbnail(resource)
    if resource.image?
      thumb = "<img class='img-thumbnail media-object' src='#{resource.image.image.url(:thumbnail)}'>"
    else
      thumb = "<i class='fa fa-leaf media-object' style='font-size: 50px'></i>"
    end
    return thumb.html_safe
  end

end