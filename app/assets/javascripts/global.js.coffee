ready = ->
  $("[data-toggle='tooltip']").tooltip()

  $(".index-search").off("keyup").on "keyup", ->
    $(this).parent().submit()

$(document).ready(ready)
$(document).on('page:load', ready)







