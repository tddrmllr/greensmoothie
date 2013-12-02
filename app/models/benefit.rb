class Benefit < ActiveRecord::Base

  belongs_to :benefactor, polymorphic: true

end
