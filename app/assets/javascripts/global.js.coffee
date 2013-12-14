$(document).on "page:load", ->
  console.log "remove"
  $('.modal-backdrop').remove()


$(document).ready ->
  $(document.body).on "page:load", ->
    window["rangy"].initialized = false
    $(".description").each (i, elem) ->
      $(elem).wysihtml5()


