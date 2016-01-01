class Nutrient < ActiveRecord::Base
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients

  default_scope -> { order('name ASC') }

  validates :name, presence: true
  validates_length_of :symbol, maximum: 3

  MACRONUTRIENT = 'Macronutrient'
  MINERAL = 'Mineral'
  VITAMIN = 'Vitamin'

  scope :macronutrients, -> { where(nutrient_type: MACRONUTRIENT) }
  scope :minerals, -> { where(nutrient_type: MINERAL) }
  scope :vitamins, -> { where(nutrient_type: VITAMIN) }

  DV = {
    "Vitamin C" => {"amount" => "60", "unit" => "mg"},
    "Thiamin" => {"amount" => "1.5", "unit" => "mg"},
    "Riboflavin" => {"amount" => "1.7", "unit" => "mg"},
    "Niacin" => {"amount" => "20", "unit" => "mg"},
    "Vitamin B-6" => {"amount" => "2", "unit" => "mg"},
    "Folate" => {"amount" => "400", "unit" => "µg"},
    "Vitamin B-12" => {"amount" => "6", "unit" => "µg"},
    "Vitamin A, RAE" => {"amount" => "900", "unit" => "µg"},
    "Vitamin E" => {"amount" => "15", "unit" => "mg"},
    "Vitamin D (D2 + D3)" => {"amount" => "15", "unit" => "µg"},
    "Vitamin K" => {"amount" => "80", "unit" => "µg"},
    "Calcium" => {"amount" => "1000", "unit" => "mg"},
    "Iron" => {"amount" => "18", "unit" => "mg"},
    "Magnesium" => {"amount" => "400", "unit" => "mg"},
    "Phosphorus" => {"amount" => "1000", "unit" => "mg"},
    "Potassium" => {"amount" => "3500", "unit" => "mg"},
    "Sodium" => {"amount" => "2400", "unit" => "mg"},
    "Zinc" => {"amount" => "15", "unit" => "mg"},
    "Calories" => {"amount" => "2000", "unit" => "kcal"},
    "Protein" => {"amount" => "50", "unit" => "g"},
    "Fat" => {"amount" => "65", "unit" => "g"},
    "Carbohydrate" => {"amount" => "300", "unit" => "mg"},
    "Fiber" => {"amount" => "25", "unit" => "mg"}
  }

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
    DV.each do |k,v|
      n = self.find_by_name(k)
      n.update_column :daily_value_amount, v["amount"]
      n.update_column :daily_value_unit, v["unit"]
    end
  end

end
