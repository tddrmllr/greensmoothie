class Nutrient < ActiveRecord::Base
  has_many :citables, as: :citer, class_name: "Citation", dependent: :destroy
  has_many :benefits, through: :citables, source: :citable, source_type: "Benefit", dependent: :destroy
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients

  accepts_nested_attributes_for :benefits, allow_destroy: true

  default_scope order: 'name ASC'

  validates :name, presence: true
  validates_length_of :symbol, maximum: 3

  VITAMINS = {
    "Vitamin C" => "Vitamin C, total ascorbic acid",
    "Thiamin" => "Thiamin",
    "Riboflavin" => "Riboflavin",
    "Niacin" => "Niacin",
    "Vitamin B-6" => "Vitamin B-6",
    "Folate" => "Folate, DFE",
    "Vitamin B-12" => "Vitamin B-12",
    "Vitamin A, RAE" => "Vitamin A, RAE",
    "Vitamin A, IU" => "Vitamin A, IU",
    "Vitamin E" => "Vitamin E (alpha-tocopherol)",
    "Vitamin D (D2 + D3)" => "Vitamin D (D2 + D3)",
    "Vitamin D" => "Vitamin D",
    "Vitamin K" => "Vitamin K (phylloquinone)"
  }

  MINERALS = {
    "Calcium" => "Ca",
    "Iron" => "Fe",
    "Magnesium" => "Mg",
    "Phosphorus" => "P",
    "Potassium" => "K",
    "Sodium" => "Na",
    "Zinc" => "Zn"
  }

  MACRONUTRIENTS = {
    "Calories" => "Energy",
    "Water" => "Water",
    "Protein" => "Protein",
    "Fat" => "Total lipid (fat)",
    "Carbohydrate" => "Carbohydrate, by difference",
    "Fiber" => "Fiber, total dietary",
    "Sugar" => "Sugars, total"
  }

  def self.find_or_create(name)
    nutrient = where(['lower(name) = ?', name]).first
    return nutrient.blank? ? Nutrient.create(name: name.titleize) : nutrient
  end

  def self.populate
    self.destroy_all
    VITAMINS.each do |k,v|
      n = Nutrient.new
      n.name = k
      n.usda_name = v
      n.nutrient_type = "Vitamin"
      n.save
    end
    MINERALS.each do |k,v|
      n = Nutrient.new
      n.name = k
      n.usda_name = k + ", #{v}"
      n.nutrient_type = "Mineral"
      n.symbol = v
      n.save
    end
    MACRONUTRIENTS.each do |k,v|
      n = Nutrient.new
      n.name = k
      n.usda_name = v
      n.nutrient_type = "Macronutrient"
      n.save
    end
  end

end
