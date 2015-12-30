class Ingredient < ActiveRecord::Base

  include HasImage
  require 'nokogiri'
  require 'open-uri'

  has_many :measurements, dependent: :destroy
  has_many :recipes, through: :measurements
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :nutrients, through: :ingredient_nutrients

  accepts_nested_attributes_for :measurements

  validates :name, presence: true

  after_create :scrape_nutrients
  after_save :rescrape_nutrients

  default_scope -> { order('name ASC') }

  def self.find_or_create(name)
    ingredient = where(['lower(name) = ?', name.downcase]).first
    ingredient || Ingredient.create(name: name.capitalize)
  end

  def macronutrients
    ingredient_nutrients.macronutrients
  end

  def minerals
    ingredient_nutrients.minerals
  end

  def vitamins
    self.ingredient_nutrients.select {|x| x.nutrient.nutrient_type == "Vitamin"}
  end

  private

  def rescrape_nutrients
    if source_url.blank?
      ingredient_nutrients.destroy_all
    elsif changes[:source_url] && created_at != updated_at
      scrape_nutrients(url: source_url, ingredient: self)
    end
  end

  def scrape_nutrients(args = {})
    Nutrients::Scrape.run(args)
  end
end
