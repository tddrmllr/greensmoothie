$(document).on 'ready page:load', ->
  if $(".summernote-post").length > 0
    $(".summernote-post").summernote
      lang: 'en-US'
