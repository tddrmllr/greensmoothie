module Posts
  class IndexPresenter < Presenter
    include InfiniteIndex

    def search_terms
      :name_or_body_or_description_cont
    end

    def title
      'The Green Smoothie Blog'
    end
  end
end
