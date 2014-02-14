ready = ->
  $("[data-toggle='tooltip']").tooltip()

  $(".index-search").off("keyup").on "keyup", ->
    $("#page").val(1)
    $("#" + $(this).data("type")).data("next", 2)
    $(this).parent().submit()

$(document).ready(ready)
$(document).on('page:load', ready)







