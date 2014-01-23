module UpdateTags
  def self.included(base)
    base.instance_eval("after_filter :update_tags, only: [:create, :update]")
  end

  private

  def update_tags
    @taggable = instance_variable_get("@#{controller_name.singularize}")
    @taggable.tag_list = params[:tags].present? ? params[:tags].map(&:inspect).join(', ').gsub("\"", "") : nil
    @taggable.save
  end
end