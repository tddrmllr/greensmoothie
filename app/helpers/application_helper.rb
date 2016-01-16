module ApplicationHelper
  def material_icon(klass, options = {})
    "<i class='zmdi zmdi-#{klass} #{options[:class]}' style='#{options[:style]}'></i>".html_safe
  end

  def named_url_for(resource)
    "/#{resource.class.name.pluralize.downcase}/#{resource.url_name}"
  end

  def title
    instance_variable_get("@#{controller_name.singularize}").try(:title) || @title || 'Green Smoothie'
  end
end
