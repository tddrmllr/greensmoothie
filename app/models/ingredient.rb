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

  def macronutrients
    self.ingredient_nutrients.select {|x| x.nutrient.nutrient_type == "Macronutrient"}
  end

  def minerals
    self.ingredient_nutrients.select {|x| x.nutrient.nutrient_type == "Mineral"}
  end

  def vitamins
    self.ingredient_nutrients.select {|x| x.nutrient.nutrient_type == "Vitamin"}
  end

  def scrape_nutrients(name=nil)
    self.ingredient_nutrients.destroy_all
    name ||= self.name
    search = "http://ndb.nal.usda.gov/ndb/foods?&qlookup=#{name}&max=200"
    results = Nokogiri::HTML(open(search))
    result = results.at_css(".wbox table tbody tr td:nth-child(2) a:contains('#{name.capitalize}, raw')")
    result ||= results.at_css(".wbox table tbody tr td:nth-child(2) a:contains('#{name.capitalize.pluralize}, raw')")
    result ||= results.at_css(".wbox table tbody tr td:nth-child(2) a:contains('#{name}')")
    return if result.blank? # couldn't find it

    url = "http://ndb.nal.usda.gov/#{result.attr('href')}"
    self.source_url = url
    page = Nokogiri::HTML(open(url))
    amount = page.css('div.nutlist table thead th:last-child input').first.attr('value')
    unit = page.css('div.nutlist table thead th:last-child input').first.next.next.text
    self.serving_size = amount + " " + unit
    Nutrient.all.each do |nutrient|
      n = page.css("div.nutlist table tbody tr.odd td:contains('#{nutrient.usda_name}')").first.parent()
      ingredient_nutrient = self.ingredient_nutrients.new
      ingredient_nutrient.nutrient_id = nutrient.id
      ingredient_nutrient.amount = n.children[6].text
      ingredient_nutrient.unit = n.children[2].text
      ingredient_nutrient.save
    end
    self.save
  end

  def self.find_or_create(name)
    ingredient = where(['lower(name) = ?', name]).first
    return ingredient.blank? ? Ingredient.create(name: name.capitalize) : ingredient
  end

  def vitamins
    self.ingredient_nutrients.select {|x| x.nutrient.nutrient_type == "Vitamin"}
  end
end
