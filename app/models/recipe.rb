class Recipe < ActiveRecord::Base
  include HasImage

  belongs_to :user
  has_many :measurements
  has_many :ingredients, through: :measurements
  has_many :ratings

  accepts_nested_attributes_for :measurements, allow_destroy: true

  validates :name, :description, presence: true
  validate :has_ingredients

  default_scope -> { order('created_at DESC') }

  def named_route
    text = self.name.strip.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
    "/recipes/#{self.id}/#{text}"
  end

  def has_ingredients
    self.errors.add(:base, "Your recipe must have at least one ingredient") unless self.measurements.collect {|x| x.ingredient }.any?
  end

  def update_rating
    update_column :rating, ratings.sum(:rating).to_d / ratings.count.to_d
  end
end
