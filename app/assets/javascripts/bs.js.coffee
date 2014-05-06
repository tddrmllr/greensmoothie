$(document).on("mouseover", "[data-toggle='popover-hover']", ->
  $(this).popover('show')
).on 'mouseout', "[data-toggle='popover-hover']", ->
  $(this).popover('hide')
