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
