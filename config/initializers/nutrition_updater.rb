require Rails.root.join('test', 'doubles', 'nutrition_updater_double.rb')
require Rails.root.join('app', 'services', 'ingredients', 'update_nutrition.rb')
NUTRITION_UPDATER = YAML::load(File.open("#{Rails.root}/config/nutrition_updater.yml"))[Rails.env].constantize
