# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->

  return unless $("#ingredient-form").length > 0

  initTypeahead = ->
    nutrients = $("#nutrients").data("array")
    $(".nutrient-input").typeahead(
      name: "nutrients"
      valueKey: "name"
      remote:
        url: "/nutrients?typeahead=true&q[name_cont]=%QUERY"
        cache: false
      limit: 5
    ).off("typeahead:selected typeahead:autocompleted").on "typeahead:selected typeahead:autocompleted", (obj, datum, name) ->
      $(this).closest("div.nutrient").find(".citable-id").val(datum["id"])
     .off("typeahead:closed").on "typeahead:closed", ->
       name = $(this).val()
       unless name is "" or checkValue(nutrients, name) is true
         elemID = $.now()
         $(this).closest("div.nutrient").find(".citable-id").attr("id", elemID)
         $.get "/nutrients/new",
           name: name
           elem: elemID
           dataType: "script"

  checkValue = (array, value) ->
    for data, i in array
      return true if data['name'] is value

  initTypeahead()

  $(document).off("nested:fieldAdded").on "nested:fieldAdded", ->
    initTypeahead()

$(document).ready(ready)
$(document).on('page:load', ready)