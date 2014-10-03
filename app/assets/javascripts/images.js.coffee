ready = ->

  return unless $("#img-form").length > 0

  $("#img-form").fileupload
    change: (e, data) ->
      $("#img-btn, #img-trigger").button("loading")

  $("#img-file").mouseover ->
    $("#img-btn").css "background-color", "#6ed31b"

  $("#img-file").mouseout ->
    $("#img-btn").css "background-color", "#83e531"

$(document).ready(ready)
$(document).on('page:load', ready)

$(document).on "click", "#img-trigger", (e) ->
  e.preventDefault()
  $("#img-file").click()

$(document).on 'paste', '#img-url', ->
  that = $(this)
  $("#img-btn, #img-trigger, #img-btn2").button("loading")
  setTimeout (->
    that.closest('form').submit()
  ), 100

$(document).on 'keyup', '#img-url', (e) ->
  code = ((if e.keyCode then e.keyCode else e.which))
  $("#img-btn, #img-trigger").button("loading") if code is 13
