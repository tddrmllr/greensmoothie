module Recipes
  class ShowPresenter < Presenter
    def title
      presentable.name
    end

    private

    def after_initialize(atts)
      # find_by_id is for legacy urls
      @presentable = Recipe.find_by_url_name(atts[:id]) || Recipe.find_by_id(atts[:id])
    end
  end
end
