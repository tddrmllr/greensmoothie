class Recipe < ActiveRecord::Base
  include HasImage

  belongs_to :user
  has_many :measurements
  has_many :ingredients, through: :measurements
  has_one :image, as: :imageable

  accepts_nested_attributes_for :measurements, allow_destroy: true

  validates :name, :description, presence: true
  validate :has_ingredient

  def has_ingredient
    self.errors.add(:base, "Your recipe must have at least one ingredient") unless self.ingredients.any?
  end
end
