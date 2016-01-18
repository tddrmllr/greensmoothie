module InfiniteIndex
  attr_accessor :page, :params, :per, :query, :type

  def ids
    index.map(&:id)
  end

  def index
    Kaminari.paginate_array(search).page(page).per(per)
  end

  def ransack
    presentable.ransack(query)
  end

  def search
    ransack.result(distinct: true)
  end

  def search_terms
    fail NotImplementedError, "InfiniteIndex presenters must implement the 'search_terms' method"
  end

  def total_count
    presentable.count
  end

  private

  def after_initialize(atts)
    @params = atts[:params]
    @page = params[:page]
    @per = atts[:per] || 12
    @type = @params[:controller].singularize
    @presentable = @type.classify.constantize
    @query = @params[:q]
  end
end
