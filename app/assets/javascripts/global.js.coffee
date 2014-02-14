ready = ->
  $("[data-toggle='tooltip']").tooltip()

  $(".index-search").off("keyup").on "keyup", ->
    $("#page").val(1)
    $("#pages").data("next", 2)
    $(this).parent().submit()

  spinner =
    lines: 12, # The number of lines to draw
    length: 5, # The length of each line
    width: 2, # The line thickness
    radius: 4, # The radius of the inner circle
    color: '#000', #rgb or #rrggbb
    speed: 1, # Rounds per second
    trail: 60, # Afterglow percentage
    shadow: false, # Whether to render a shadow
    bottom: 0,
    className: 'spinner'

  $(window).scroll ->
    if $(window).scrollTop() + $(window).height() is $(document).height()
      $("#pages").spin(spinner) unless parseInt($("#pages").data("next")) > parseInt($("#pages").data("page-count"))
      $("#page").val($("#pages").data("next"))
      $(".index-search").parent().submit()

$(document).ready(ready)
$(document).on('page:load', ready)







