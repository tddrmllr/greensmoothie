# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->

  return unless $("#ingredient-form").length > 0

  initTypeahead = ->
    $(".nutrient-input").typeahead(
      name: "nutrients"
      valueKey: "name"
      remote:
        url: "/nutrients?typeahead=true&q[name_cont]=%QUERY"
        cache: false
      limit: 7
    )

  initTypeahead()

  $(document).off("nested:fieldAdded").on "nested:fieldAdded", ->
    initTypeahead()

$(document).ready(ready)
$(document).on('page:load', ready)
