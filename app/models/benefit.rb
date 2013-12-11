class Benefit < ActiveRecord::Base

  has_one :citation, as: :citable

  accepts_nested_attributes_for :citation, allow_destroy: true

end
