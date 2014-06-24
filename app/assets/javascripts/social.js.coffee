
ready = ->

  if $("#livefyre-comments").length > 0
    (->
      articleId = fyre.conv.load.makeArticleId(null)
      fyre.conv.load {}, [
        el: "livefyre-comments"
        network: "livefyre.com"
        siteId: "360774"
        articleId: articleId
        signed: false
        collectionMeta:
          articleId: articleId
          url: fyre.conv.load.makeCollectionUrl()
      ], ->
      return
    )()

  return unless $("#social").length > 0

  $(".facebook").click ->
    sharer = "https://www.facebook.com/sharer/sharer.php?s=100&p[url]="
    left = (screen.width/2)-(626/2);
    top = (screen.height/2)-(436/2);
    url = $(this).data('url')
    media = $(this).data('media')
    title = $(this).data('title')
    summary = $(this).data('summary')
    window.open sharer + url + "&p[images][0]=" + media + "&p[title]=" + title + "&p[summary]=" + summary, "sharer", "menubar=no,toolbar=no,status=no,width=626,height=436,toolbar=no,left=" + left + ",top=" + top
  $(".twitter").click ->
    sharer = "https://twitter.com/intent/tweet?status="
    left = (screen.width/2)-(626/2);
    top = (screen.height/2)-(225/2);
    title = $(this).data('desc')
    url = $(this).data('url')
    window.open sharer + title + " " + url, "sharer", "menubar=no,toolbar=no,status=no,width=626,height=225,toolbar=no,left=" + left + ",top=" + top
  $(".pinterest").click ->
    sharer = "//pinterest.com/pin/create/button/?url="
    left = (screen.width/2)-(750/2);
    top = (screen.height/2)-(300/2);
    summary = $(this).data('summary')
    media = $(this).data('media')
    url = $(this).data('url')
    window.open sharer + url + "&media=" + media + "&description=" + summary, "sharer", "menubar=no,toolbar=no,status=no,width=750,height=300,toolbar=no,left=" + left + ",top=" + top
  $(".google").click ->
    sharer = "https://plus.google.com/share?url="
    left = (screen.width/2)-(550/2);
    top = (screen.height/2)-(400/2);
    url = $(this).data('url')
    window.open sharer + url, "sharer", "menubar=no,toolbar=no,status=no,width=550,height=400,toolbar=no,left=" + left + ",top=" + top


$(document).ready(ready)
$(document).on('page:load', ready)
