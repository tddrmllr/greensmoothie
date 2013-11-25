class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :measurements
  has_many :ingredients, through: :measurements

  accepts_nested_attributes_for :measurements, allow_destroy: true


end
