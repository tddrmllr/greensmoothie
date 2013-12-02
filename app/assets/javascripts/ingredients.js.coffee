# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(document.body).on "nested:fieldAdded", (event) ->
    $(".ingredient-input").typeahead
      name: "ingredients"
      valueKey: "name"
      remote: "/ingredients"
      limit: 10

