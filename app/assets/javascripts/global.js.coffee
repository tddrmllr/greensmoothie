$(document).on "click", "[data-loading-text]", ->
  $(this).button("loading")

$(window).on 'scroll', ->
  if $(window).scrollTop() + $(window).height() is $(document).height()
    unless parseInt($("#pages").data("next")) > parseInt($("#pages").data("page-count"))
      $("#pages").spin(spinner)
      $("#page").val($("#pages").data("next"))
      $(".index-search").parent().submit()

spinner =
  lines: 12, # The number of lines to draw
  length: 5, # The length of each line
  width: 2, # The line thickness
  radius: 4, # The radius of the inner circle
  color: '#000', #rgb or #rrggbb
  speed: 1, # Rounds per second
  trail: 60, # Afterglow percentage
  shadow: false, # Whether to render a shadow
  bottom: 0,
  className: 'spinner'

ready = ->

  $(".index-search").on "keyup", ->
    $("#page").val(1)
    $("#pages").data("next", 2)
    $(this).parent().submit()

  if App.mobile() && $(".summernote").length > 0
    $(".summernote").summernote
      lang: 'en-US'
      toolbar: [
        ['font', ['bold', 'italic', 'underline', 'clear']]
        ['para', ['ul', 'ol']]
        ['insert', ['link', 'picture']]
        ['view', ['fullscreen', 'codeview']]
      ]
      onfocus: ->
        $(".cke").remove()

  $("[data-toggle='tooltip']").tooltip()

  unless App.mobile()
    $("[data-hover=\"dropdown\"]").dropdownHover delay: 100
    $("[data-hover=\"dropdown\"]").click ->
      window.location.href = $(this).attr("href")

$(document).ready(ready)
$(document).on('page:load', ready)

$(document).on "click", ".delete", (e) ->
    e.preventDefault()
    $("#confirm-delete").button("reset")
    text = $(this).data("text")
    title = $(this).data("title")
    url = $(this).data("url")
    $("#confirm-delete").attr('href', url)
    $("#delete-modal #text").html(text)
    $("#delete-title").html(title)
    $("#confirm-delete").button("reset")
    $(".modal").modal("hide")
    $("#delete-modal").modal("show")

window.App = {}

App.mobile = ->
  mobile = (/iPhone|iPod|iPad|Android|BlackBerry/).test navigator.userAgent
  return mobile

App.android = ->
  mobile = (/Android/).test navigator.userAgent
  return mobile
