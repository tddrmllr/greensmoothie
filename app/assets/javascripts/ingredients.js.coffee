# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  return unless $("#recipe-form").length > 0

  $(document.body).on "nested:fieldAdded", (event) ->
    initTypeahead()

  $(document).on "ready", (event) ->
    initTypeahead()

  initTypeahead = ->
    $(".ingredient-input").typeahead(
      name: "ingredients"
      valueKey: "name"
      prefetch: "/ingredients"
      limit: 10
    ).on "typeahead:selected", (obj, datum, name) ->
      $(this).closest("div.ingredient").find(".ingredient-id").val(datum["id"])

