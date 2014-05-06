# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  return if $("#recipes").length is 0 or $(window).width() <= 480

  $("#recipes").imagesLoaded ->
    $("#recipes").masonry
      itemSelector: ".grid"
      columnWidth: (containerWidth) ->
        containerWidth / 4

$(document).ready(ready)
$(document).on('page:load', ready)
