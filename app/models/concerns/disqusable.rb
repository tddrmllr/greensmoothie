module Disqusable
  def disqus_id
    "#{self.class.name.downcase}-#{id}"
  end
end
