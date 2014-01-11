module TagsHelper

  def edit_tags
    html = ""
    @taggable = instance_variable_get("@#{controller_name.singularize}")
    @taggable.tags.each do |t|
      html += "<span class='label label-tag edit-tag'>" +
                "<a href='#' class='remove-tag'><i class='fa fa-times'></i></a>" +
                t.name +
                "<input value='#{t.name}' type='hidden' name='tags[]'>" +
              "</span>"
    end
    html.html_safe
  end
end