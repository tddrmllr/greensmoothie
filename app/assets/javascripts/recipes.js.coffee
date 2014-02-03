# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  return unless $("#recipes").length > 0

  container = document.querySelector("#recipes")
  msnry = new Masonry(container,

    # options
    itemSelector: ".grid"
    columnWidth: container.querySelector('.size')
  )
  msnry.bindResize()


$(document).on('page:load', ready)