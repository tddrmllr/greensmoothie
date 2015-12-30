class Measurement < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  validates :ingredient, presence: true
end
