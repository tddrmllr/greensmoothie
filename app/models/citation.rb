class Citation < ActiveRecord::Base

  belongs_to :citable, polymorphic: true
  belongs_to :citer, polymorphic: true
end