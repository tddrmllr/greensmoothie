# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  return unless $("#recipe-form").length > 0

  initTypeahead = ->
    $(".ingredient-input").typeahead
      name: "ingredients"
      valueKey: "name"
      remote:
        url: "/ingredients?typeahead=true&q[name_cont]=%QUERY"
        cache: false
      limit: 7

  initTypeahead()

  $(document).off("nested:fieldAdded").on "nested:fieldAdded", (event) ->
    initTypeahead()

$(document).ready(ready)
$(document).on('page:load', ready)
