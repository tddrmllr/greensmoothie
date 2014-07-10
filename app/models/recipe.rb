class Recipe < ActiveRecord::Base
  include HasImage
  unless (ARGV & ['assets:precompile', 'assets:clean']).any?
    acts_as_taggable
  end

  belongs_to :user
  has_many :measurements
  has_many :ingredients, through: :measurements
  has_many :comments, as: :commentable
  has_many :ratings

  accepts_nested_attributes_for :measurements, allow_destroy: true

  validates :name, :description, presence: true
  validate :has_ingredients

  default_scope order('created_at DESC')

  def named_route
    text = self.name.strip.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
    "/recipes/#{self.id}/#{text}"
  end

  def has_ingredients
    self.errors.add(:base, "Your recipe must have at least one ingredient") unless self.measurements.collect {|x| x.ingredient }.any?
  end

  def update_rating
    rating = self.ratings.sum(&:rating).to_f / self.ratings.count.to_f
    update_column(:rating, rating)
  end
end
