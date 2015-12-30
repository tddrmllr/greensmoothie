class Image < ActiveRecord::Base

  has_attached_file :image, storage: :s3, s3_credentials: S3, :styles => { :medium => '300x300>', :thumb => '150x150>', large: '500x500' }, :default_url => '/assets/glass.png', processors: [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :image_url

  belongs_to :imageable, polymorphic: true

  validate :image_from_url
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type=>['image/jpeg', 'image/png', 'image/gif']

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def image_geometry(style = :original)
    @image ||= {}
    @image[style] ||= Paperclip::Geometry.from_file(image.url(style))
  end

  private

  def image_from_url
    self.image = URI.parse(image_url) if image_url
  rescue
    errors[:base] << 'Invalid URL'
  end
end
