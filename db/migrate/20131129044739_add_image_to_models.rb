class AddImageToModels < ActiveRecord::Migration
  def change
    add_attachment :ingredients, :image
    add_attachment :recipes, :image
  end
end
