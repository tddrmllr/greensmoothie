ready = ->

  return unless $("#tag-field").length > 0

  $("a.remove-tag").on "click", ->
    $(this).parent().remove()

  initTagger = ->
    $("#tag-field").on "keydown", (e) ->
      if e.keyCode is 13
        e.preventDefault()
        unless $(this).val() is ""
          hash = {}
          hash["name"] = $(this).val()
          insertTag(hash)
          $(this).focus()

    $("#tag-field").on "focusout", (e) ->
      unless $(this).val() is ""
        hash = {}
        hash["name"] = $(this).val()
        insertTag(hash)
        $(this).focus()

    taglist = $("#tag-field").data("taglist")
    $("#tag-field").typeahead(
      name: "tags"
      valueKey: "name"
      local: taglist
      limit: 10
    ).off("typeahead:selected").on "typeahead:selected", (obj, datum, name) ->
      insertTag(datum)
     .off("typeahead:autocompleted").on "typeahead:autocompleted", (obj, datum, name) ->
      insertTag(datum)
     .off("typeahead:closed").on "typeahead:closed", ->


    insertTag = (datum) ->
      tag = $('<span>',
        class: 'label label-tag edit-tag'
        text: datum["name"].toLowerCase()
      )
      field = $('<input>',
        type: 'hidden'
        name: 'tags[]'
        value: datum["name"].toLowerCase()
      )
      tag.prepend("<a href='#remove' class='remove-tag'><i class='fa fa-times'></i></a>")
      tag.append(field)
      $("#tag-list").prepend(tag)
      $("#tag-field").typeahead("setQuery", "")
      $("a.remove-tag").on "click", ->
        $(this).parent().remove()

    checkValue = (array, value) ->
      for data, i in array
        return true if data['name'] is value

  initTagger()

$(document).ready(ready)
$(document).on('page:load', ready)