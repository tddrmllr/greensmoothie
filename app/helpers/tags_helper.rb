module TagsHelper

  def edit_tags(taggable)
    if taggable.tags.any?
      html = ""
      taggable.tags.each do |t|
      html += "<span class='label label-tag edit-tag'>" +
                "<a href='#remove' class='remove-tag'><i class='fa fa-times'></i></a>" +
                t.name +
                "<input value='#{t.name}' type='hidden' name='tags[]'>" +
              "</span>"
    end
    html.html_safe
    end
  end

  def show_tags(taggable)
    if taggable.tags.any?
      html = "<span class='tags'>Tags: &nbsp;</span>"
      taggable.tags.each do |t|
        html += "<a href='#tag' class='tag'>#{t.name}</a>"
      end
      html.html_safe
    end

  end

end