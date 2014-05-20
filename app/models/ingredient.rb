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

  def self.find_or_create(name)
    ingredient = where(['lower(name) = ?', name]).first
    return ingredient.blank? ? Ingredient.create(name: name.capitalize) : ingredient
  end

  def macronutrients
    self.ingredient_nutrients.select {|x| x.nutrient.nutrient_type == "Macronutrient"}
  end

  def minerals
    self.ingredient_nutrients.select {|x| x.nutrient.nutrient_type == "Mineral"}
  end

  def rescrape_nutrients
    if !self.changes[:source_url].blank? && self.created_at != self.updated_at
      self.scrape_nutrients(nil, self.source_url)
    end
  end

  def scrape_nutrients(name=nil, url=nil)
    self.ingredient_nutrients.destroy_all
    if url.nil?
      name ||= self.name
      search = URI.encode("http://ndb.nal.usda.gov/ndb/foods?&qlookup=#{name}&max=200")
      results = Nokogiri::HTML(open(search))
      result = results.at_css(".wbox table tbody tr td:nth-child(2) a:contains('#{name.capitalize}, raw')")
      result ||= results.at_css(".wbox table tbody tr td:nth-child(2) a:contains('#{name.capitalize.pluralize}, raw')")
      result ||= results.at_css(".wbox table tbody tr td:nth-child(2) a:contains('#{name}')")
    end
    return if result.blank? && url.nil?
    url ||= "http://ndb.nal.usda.gov/#{result.attr('href')}"
    page = Nokogiri::HTML(open(url))
    return if page.css('div.nutlist').blank?
    input = page.css('div.nutlist table thead th input:not(#Qv)').first
    amount = input.attr('value')
    unit = input.next.next.text
    serving_size = amount + " " + unit
    self.update_column :serving_size, serving_size
    self.update_column :source_url, url
    self.update_column :usda_name, page.css('#view-name').text
    headers = page.css('div.nutlist table thead th')
    column_values = headers.index(input.parent)
    column_unit = headers.index(page.at_css("div.nutlist table thead th:contains('Unit')"))
    Nutrient.all.each do |nutrient|
      n = page.css("div.nutlist table tbody tr.odd td:contains('#{nutrient.usda_name}')")
      unless n.blank?
        row = n.first.parent()
        children = row.children.select {|x| x.name == 'td'}
        ingredient_nutrient = self.ingredient_nutrients.new
        ingredient_nutrient.nutrient_id = nutrient.id
        ingredient_nutrient.amount = children[column_values].text
        ingredient_nutrient.unit = children[column_unit].text
        ingredient_nutrient.save
      end
    end
  end

  def vitamins
    self.ingredient_nutrients.select {|x| x.nutrient.nutrient_type == "Vitamin"}
  end
end
