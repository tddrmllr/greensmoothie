# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  return unless $("#home").length > 0

  $("body").css
    'background': "url('/assets/home.jpg') no-repeat fixed top"
    '-webkit-background-size': 'cover'
    '-moz-background-size': 'cover'
    '-o-background-size': 'cover'
    'background-size': 'cover'

$(document).ready(ready)
$(document).on('page:load', ready)