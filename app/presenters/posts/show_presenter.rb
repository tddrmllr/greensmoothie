module Posts
  class ShowPresenter < Presenter

    def title
      presentable.name
    end

    private

    def after_initialize(atts)
      @presentable = Post.unscoped.find_by_url_name(atts[:url_name])
    end
  end
end
