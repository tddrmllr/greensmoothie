module Searchable

  def self.included(base)
    base.instance_eval("before_filter :searchable, only: [:index]")
  end

  private

  def searchable
    @search = controller_name.classify.constantize.search(params[:q])
    instance_variable_set("@#{controller_name}", @search.result(distinct: true))
    render 'layouts/index' if request.xhr?
  end
end