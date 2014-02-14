<% if params[:page].to_i > 1 %>
  $("#recipes").append("<%= escape_javascript(render @recipes) %>")
  $("#recipes").data("next", <%= params[:page].to_i + 1 %>)
  $("#recipes").imagesLoaded ->
    $("#recipes").masonry "reload"
<% else %>
  $("#recipes").html "<%= escape_javascript(render @recipes) %>"
  $("#recipes").imagesLoaded ->
    $("#recipes").masonry
      itemSelector: ".grid"
      columnWidth: (containerWidth) ->
        containerWidth / 4

    $("#recipes").masonry "reload"
    $("#recipes").data("next", 2)
<% end %>