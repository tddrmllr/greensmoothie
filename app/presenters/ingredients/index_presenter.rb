module Ingredients
  class IndexPresenter < Presenter
    include InfiniteIndex

    def search_terms
      :name_or_description_or_nutrients_name_cont
    end

    def title
      'Ingredients'
    end
  end
end
