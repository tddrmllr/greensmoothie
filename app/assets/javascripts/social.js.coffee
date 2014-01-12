### TWITTER ###

twttr_events_bound = false

$ ->
  bindTwitterEventHandlers() unless twttr_events_bound

bindTwitterEventHandlers = ->
  $(document).on 'page:load', renderTweetButtons
  twttr_events_bound = true

renderTweetButtons = ->
  $('.twitter-share-button').each ->
    button = $(this)
    button.attr('data-url', document.location.href) unless button.data('url')?
    button.attr('data-text', document.title) unless button.data('text')?
  twttr.widgets.load()

### FACEBOOK ###

fb_root = null
fb_events_bound = false

$ ->
  loadFacebookSDK()
  bindFacebookEvents() unless fb_events_bound

bindFacebookEvents = ->
  $(document)
    .on('page:fetch', saveFacebookRoot)
    .on('page:change', restoreFacebookRoot)
    .on('page:load', ->
      FB?.XFBML.parse()
    )
  fb_events_bound = true

saveFacebookRoot = ->
  fb_root = $('#fb-root').detach()

restoreFacebookRoot = ->
  if $('#fb-root').length > 0
    $('#fb-root').replaceWith fb_root
  else
    $('body').append fb_root

loadFacebookSDK = ->
  window.fbAsyncInit = initializeFacebookSDK
  $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1")

initializeFacebookSDK = ->
  FB.init
    appId     : '584721794928673'
    status    : true
    cookie    : true
    xfbml     : true

ready = ->
  ### PINTEREST ###

  ((d) ->
    f = d.getElementsByTagName("SCRIPT")[0]
    p = d.createElement("SCRIPT")
    p.type = "text/javascript"
    p.async = true
    p.src = "//assets.pinterest.com/js/pinit.js"
    f.parentNode.insertBefore p, f
  ) document

  ### GOOGLE ###

  (->
    po = document.createElement("script")
    po.type = "text/javascript"
    po.async = true
    po.src = "https://apis.google.com/js/plusone.js?onload=onLoadCallback"
    s = document.getElementsByTagName("script")[0]
    s.parentNode.insertBefore po, s
  )()

$(document).ready(ready)
$(document).on('page:load', ready)
