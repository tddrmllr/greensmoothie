class Ingredient < ActiveRecord::Base
  include Disqusable
  include HasImage

  has_many :measurements, dependent: :destroy
  has_many :recipes, through: :measurements
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :nutrients, through: :ingredient_nutrients

  accepts_nested_attributes_for :measurements

  validates :name, presence: true
  validates_uniqueness_of :name

  after_create :create_nutrition_info
  after_save :update_nutrition_info
  before_save :set_url_name, :cleanup_instructions

  default_scope -> { order('name ASC') }

  def self.find_or_initialize(name)
    where(['lower(name) = ?', name.downcase]).first || Ingredient.new(name: name.capitalize)
  end

  def macronutrients
    ingredient_nutrients.macronutrients
  end

  def minerals
    ingredient_nutrients.minerals
  end

  def vitamins
    ingredient_nutrients.vitamins
  end

  private

  def cleanup_instructions
    self.description = '' if description == "<p><br></p>"
  end

  def create_nutrition_info(args = { url: source_url, ingredient: self })
    NUTRITION_UPDATER.run(args)
  end

  def set_url_name
    self.url_name = (name || '').downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end

  def update_nutrition_info
    if source_url.blank?
      ingredient_nutrients.destroy_all
    elsif changes[:source_url] && created_at != updated_at
      create_nutrition_info(url: source_url, ingredient: self)
    end
  end
end
