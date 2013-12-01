$(document).ready ->

  $("#img-file").mouseover ->
    $("#img-btn").css "background-color", "#6ed31b"

  $("#img-file").mouseout ->
    $("#img-btn").css "background-color", "#83e531"

  $(document.body).on "change", "#img-file", ->
    #$("#img-submit").click()

  $("#img-form").fileupload()

