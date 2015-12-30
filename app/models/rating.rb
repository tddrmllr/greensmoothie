class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  after_save :update_recipe

  private

  def update_recipe
    recipe.update_rating
  end
end
