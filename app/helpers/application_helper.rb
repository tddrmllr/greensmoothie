module ApplicationHelper
  def material_icon(klass, options = {})
    "<i class='zmdi zmdi-#{klass} #{options[:class]}' style='#{options[:style]}'></i>".html_safe
  end

  def title
    @title ||= "Green Smoothie"
  end
end
