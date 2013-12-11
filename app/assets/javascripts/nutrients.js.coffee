# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  return unless $("#ingredient-form").length > 0

  $(document.body).on "nested:fieldAdded", (event) ->
    initTypeahead()

  $(document).on "ready", (event) ->
    initTypeahead()

  initTypeahead = ->
    $(".nutrient-input").typeahead(
      name: "nutrients"
      valueKey: "name"
      remote: "/nutrients"
      limit: 10
    ).on "typeahead:selected", (obj, datum, name) ->
      $(this).closest("div.nutrient").find(".citable-id").val(datum["id"])