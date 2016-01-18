name = "<%= escape_javascript(controller_name).singularize %>"
<% indexable = instance_variable_get("@#{controller_name}") %>
<% if params[:page].to_i > 1 %>
$(".spinner").remove()
unless parseInt($("#pages").data("next")) > parseInt($("#pages").data("page-count"))
  $("#" + name + "s").append("<%= escape_javascript(render indexable.index) %>")
  $("#pages").data("next", <%= params[:page].to_i + 1 %>)
  ids = <%= indexable.ids.to_json %>
  for i of ids
    $("#" + name + "-" + ids[i]).hide()
  $("#" + name + "s").imagesLoaded ->
    for i of ids
      $("#" + name + "-" + ids[i]).fadeIn()
<% else %>
$("#" + name + "s").html "<%= escape_javascript(render indexable.index) %>"
<% end %>
