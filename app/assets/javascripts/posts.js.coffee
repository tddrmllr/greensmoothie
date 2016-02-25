$(document).on 'ready page:load', ->
  if $(".summernote-post").length > 0
    $(".summernote-post").summernote
      lang: 'en-US'
  if $('#post-image-url').length > 0
    $('body').css
      "background": "url('#{$('#post-image-url').data('url')}') no-repeat fixed top"
      "-webkit-background-size": "cover"
      "-moz-background-size": "cover"
      "-o-background-size": "cover"
      "background-size": "cover"

$(document).on 'click', '#post-publish', (e) ->
  e.preventDefault()
  $('#post_published_at').val(new Date)
  $('.edit_post').submit()
