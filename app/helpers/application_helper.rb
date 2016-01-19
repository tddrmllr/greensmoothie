module ApplicationHelper
  def infinite_index(indexable, html_options={})
    render 'shared/infinite_index', indexable: indexable, html_options: html_options
  end

  def material_icon(klass, options = {})
    "<i class='zmdi zmdi-#{klass} #{options[:class]}' style='#{options[:style]}'></i>".html_safe
  end

  def named_url_for(resource)
    "/#{resource.class.name.pluralize.downcase}/#{resource.url_name}"
  end

  def title
    controller_instance_variable || @title || 'Green Smoothie'
  end

  private

  def controller_instance_variable
    instance_variable_get("@#{controller_name.singularize}").try(:title) || instance_variable_get("@#{controller_name}").try(:title)
  end
end
