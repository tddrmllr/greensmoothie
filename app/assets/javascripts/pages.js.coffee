# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  if $("#home").length > 0
    if App.mobile()
      $("body").addClass("home-mobile")
    else
      $("body").addClass("home")

  unless $(document).height() > $(window).height()
    $("footer").css
      width: '100%'
      position: 'absolute'
      bottom: '5px'

$(document).ready(ready)
$(document).on('page:load', ready)
