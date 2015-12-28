$(document).on 'ready page:load', ->
  $("#mobile-menu").sidr
    source: "#sidr"
    displace: false
    renaming: false
    onOpen: ->
      $('body').prepend "<div id='nav-backdrop' style='z-index: 1000; background-color: rgba(0,0,0,0.5); position: fixed; top: 0px; bottom: 0px; left: 0px; right: 0px; display: none'></div>"
      $('#nav-backdrop').fadeIn()
    onClose: ->
      $('#nav-backdrop').fadeOut()
      $('#nav-backdrop').remove()

$(document).on 'click', '#nav-backdrop', ->
  $(this).fadeOut('fast', ->
    $.sidr('close')
    $('#nav-backdrop').remove()
  )
