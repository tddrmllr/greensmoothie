$(document).ready ->
  $(document.body).on "page:load", ->
    window["rangy"].initialized = false
    $(".description").each (i, elem) ->
      $(elem).wysihtml5()


