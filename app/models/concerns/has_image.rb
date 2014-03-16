module HasImage
  def self.included(base)
    base.instance_eval("after_initialize :random_token")
    base.instance_eval("attr_accessor :image_token")
  end

  def image?
    !self.image.nil? && self.image.image.url != "/assets/glass.png"
  end

  def random_token
    self.image_token = SecureRandom.hex(10)
    while Image.where(token: self.image_token).any?
      self.image_token = SecureRandom.hex(10)
    end
  end
end