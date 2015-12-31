module Ingredients
  class UpdateNutrition
    attr_accessor :ingredient, :name, :url

    def self.run(args = {})
      new(args).run
    end

    def initialize(args)
      @ingredient = args[:ingredient]
      @url = args[:url]
      @name = args[:name] || @ingredient.name
    end

    def run
      nutrition_info = Nutrients::Scrape.run(url: url, name: name)
      ingredient.ingredient_nutrients.destroy_all
      return if nutrition_info.is_a?(Nutrients::MissingInfo)
      update_ingredient(nutrition_info)
      create_ingredient_nutrients(nutrition_info)
    rescue
      ingredient.source_url = "Error"
    end

    def create_ingredient_nutrients(info)
      Nutrient.all.each do |nutrient|
        create_ingredient_nutrient(nutrient, info)
      end
    end

    def create_ingredient_nutrient(nutrient, info)
      ingredient.ingredient_nutrients.create(
        nutrient_id: nutrient.id,
        amount: info.amount(nutrient),
        unit: info.unit(nutrient)
      ) if info.has_nutrient?(nutrient)
    end

    def update_ingredient(info)
      ingredient.update_column :serving_size, info.serving_size
      ingredient.update_column :source_url, info.url
      ingredient.update_column :usda_name, info.usda_name
    end
  end
end
