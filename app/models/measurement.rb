class Measurement < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  validates :ingredient, presence: true

  delegate :name, to: :ingredient, prefix: true, allow_nil: true

  def ingredient_name=(value)
    self.ingredient = Ingredient.find_or_initialize(value)
  end
end
