(($, window, undefined_) ->
  $allDropdowns = undefined
  $allDropdowns = $()
  $.fn.dropdownHover = (options) ->
    $allDropdowns = $allDropdowns.add(@parent())
    @each ->
      $parent = undefined
      $this = undefined
      data = undefined
      defaults = undefined
      settings = undefined
      timeout = undefined
      $this = $(this)
      $parent = $this.parent()
      defaults =
        delay: 500
        instantlyCloseOthers: true

      data =
        delay: $(this).data("delay")
        instantlyCloseOthers: $(this).data("close-others")

      settings = $.extend(true, {}, defaults, options, data)
      timeout = undefined
      $parent.hover ((event) ->
        return true  if not $parent.hasClass("open") and not $this.is(event.target)
        $allDropdowns.removeClass "open"  if settings.instantlyCloseOthers is true
        window.clearTimeout timeout
        $parent.addClass "open"
      ), ->
        timeout = window.setTimeout(->
          $parent.removeClass "open"
        , settings.delay)

      $this.hover ->
        $allDropdowns.removeClass "open"  if settings.instantlyCloseOthers is true
        window.clearTimeout timeout
        $parent.addClass "open"

) jQuery, this
