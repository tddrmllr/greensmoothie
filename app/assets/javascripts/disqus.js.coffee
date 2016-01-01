$(document).on 'ready page:load', ->
  disqus = $('#disqus_thread')
  Disqus.setup(disqus) if disqus.length > 0

class @Disqus
  @setup: (disqus) ->
    disqus_config = ->
      @page.url = window.location.href
      @page.identifier = disqus.data('id')
      @page.title = disqus.data('title')

    d = document
    s = d.createElement('script')
    s.src = '//greensmoothieme.disqus.com/embed.js'
    s.setAttribute 'data-timestamp', +new Date
    (d.head or d.body).appendChild s

  @reset: (id, url, title) ->
    DISQUS.reset
      reload: true
      config: ->
        @page.identifier = id
        @page.url = url + "#!"
        @page.title = title
