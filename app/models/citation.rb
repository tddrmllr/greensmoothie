class Citation < ActiveRecord::Base
  belongs_to :citable, polymorphic: true
  belongs_to :citer, polymorphic: true

  def valid_source
    uri = URI.parse(self.source)
    uri.kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
    return false
  end
end