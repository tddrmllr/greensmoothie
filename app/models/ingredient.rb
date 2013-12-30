class Ingredient < ActiveRecord::Base

  include HasImage

  has_many :measurements, dependent: :destroy
  has_many :recipes, through: :measurements
  has_one :image, as: :imageable
  has_many :citations, as: :citer, dependent: :destroy
  has_many :nutrients, through: :citations, source: :citable, source_type: "Nutrient"

  accepts_nested_attributes_for :citations, allow_destroy: true
  validate :citation_sources

  accepts_nested_attributes_for :measurements

  validates :name, presence: true

  def citation_sources
    self.errors.add(:base, "All citations must have a valid source (i.e., http://www.article.com)") if self.citations.select {|x| !x.valid_source? }.any?
  end
end
