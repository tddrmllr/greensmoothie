# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  return unless $("#recipe-form").length > 0

  initTypeahead = ->
    ingredients = $("#ingredients").data("array")
    $(".ingredient-input").typeahead(
      name: "ingredients"
      valueKey: "name"
      remote:
        url: "/ingredients?typeahead=true&q[name_cont]=%QUERY"
        cache: false
      limit: 5
    ).off("typeahead:selected typeahead:autocompleted").on "typeahead:selected typeahead:autocompleted", (obj, datum, name) ->
      $(this).closest("div.ingredient").find(".ingredient-id").val(datum["id"])
     .off("typeahead:closed").on "typeahead:closed", ->
       name = $(this).val()
       unless name is "" or checkValue(ingredients, name) is true
         elemID = $.now()
         $(this).closest("div.ingredient").find(".ingredient-id").attr("id", elemID)
         $.get "/ingredients/new",
           name: name
           elem: elemID
           dataType: "script"

  checkValue = (array, value) ->
    for data, i in array
      return true if data['name'] is value

  initTypeahead()

  $(document).off("nested:fieldAdded").on "nested:fieldAdded", (event) ->
    initTypeahead()

$(document).ready(ready)
$(document).on('page:load', ready)