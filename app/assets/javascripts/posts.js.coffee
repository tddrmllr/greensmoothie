$(document).on 'ready page:load', ->
  if $(".summernote-post").length > 0
    $(".summernote-post").summernote
      lang: 'en-US'

$(document).on 'click', '#post-publish', (e) ->
  e.preventDefault()
  $('#post_published_at').val(new Date)
  $('.edit_post').submit()
