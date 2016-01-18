module Nutrients
  class IndexPresenter < Presenter
    include InfiniteIndex

    def search_terms
      :name_or_description_cont
    end

    def title
      'Nutrients'
    end
  end
end
