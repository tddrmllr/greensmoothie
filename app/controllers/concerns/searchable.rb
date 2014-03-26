module Searchable

  def self.included(base)
    base.instance_eval("before_filter :searchable, only: [:index]")
  end

  private

  def searchable
      @search = controller_name.classify.constantize.search(params[:q])
      instance_variable_set("@#{controller_name}", Kaminari.paginate_array(@search.result(distinct: true)).page(params[:page]).per(12))
      if request.xhr? && params[:typeahead] == "true"
        render json: @search.result
      elsif request.xhr?
        render 'layouts/index'
      end
  end
end