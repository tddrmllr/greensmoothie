module HasImage

  def self.included(base)
    base.instance_eval("has_attached_file :image, :styles => { :medium => '300x300>', :thumb => '150x150>', large: '500x500' }, :default_url => '/images/:style/missing.png', processors: [:cropper]")
    base.instance_eval("attr_accessor :crop_x, :crop_y, :crop_w, :crop_h")
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def image_geometry(style = :original)
    @image ||= {}
    @image[style] ||= Paperclip::Geometry.from_file(image.path(style))
  end
end