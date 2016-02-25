$(document).on 'scroll', ->
  if $(window).scrollTop() > 0
    $('nav').addClass('z-depth-1')
  else
    $('nav').removeClass('z-depth-1')
