# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  return unless $(".rating").length > 0

  $(document).off(".rate").on "mouseover", ".rate", ->
    $(this).css "color" : "#5cb85c"
    $(this).prevAll(".rate").css "color" : "#5cb85c"
    $(".taste").text($(this).data("taste"))

  $(document).off(".rate").on "mouseout", ".rate", ->
    $(".rate").css "color" : "#cccccc"
    $(".taste").text("How'd it taste?")

  $(document).off(".rate").on "click", ".rate", ->
    rating = $(this).data("rating")
    recipe = $("#rating_recipe_id").val()
    $.post '/recipes/' + recipe + '/ratings?rating=' + rating



$(document).ready(ready)
$(document).on('page:load', ready)