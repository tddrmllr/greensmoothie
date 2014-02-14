<% if params[:page].to_i > 1 %>
  $(".spinner").remove()
  unless parseInt($("#pages").data("next")) > parseInt($("#pages").data("page-count"))
    $("#recipes").append("<%= escape_javascript(render @recipes) %>")
    $("#pages").data("next", <%= params[:page].to_i + 1 %>)
    ids = <%= @recipes.map(&:id).to_json %>
    elems = []
    for i of ids
      $("#recipe-" + ids[i]).hide()
    $("#recipes").imagesLoaded ->
      $("#recipes").masonry "reload"
      for i of ids
        $("#recipe-" + ids[i]).fadeIn()
<% else %>
  $("#recipes").html "<%= escape_javascript(render @recipes) %>"
  $("#recipes").imagesLoaded ->
    $("#recipes").masonry
      itemSelector: ".grid"
      columnWidth: (containerWidth) ->
        containerWidth / 4

    $("#recipes").masonry "reload"
    $("#pages").data("next", 2)
<% end %>