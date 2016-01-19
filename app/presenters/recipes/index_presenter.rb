module Recipes
  class IndexPresenter < Presenter
    include InfiniteIndex

    def search_terms
      :name_or_description_or_ingredients_name_cont
    end

    def title
      'Green Smoothie Recipes'
    end
  end
end
