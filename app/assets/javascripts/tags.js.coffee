ready = ->

  return unless $("#tag-field").length > 0

  initTagger = ->
    taglist = $("#tag-field").data("taglist")
    $("#tag-field").typeahead(
      name: "tags"
      valueKey: "name"
      local: ["poo", "pee"]
      limit: 10
    ).off("typeahead:selected").on "typeahead:selected", (obj, datum, name) ->
      insertTag(datum)
     .off("typeahead:autocompleted").on "typeahead:autocompleted", (obj, datum, name) ->
      insertTag(datum)
     .off("typeahead:closed").on "typeahead:closed", (obj, datum, name) ->
      ### How do I preventDefault here?
      e.preventDefault() if code is 9 or code is 13
      val = $(this).val()
      unless checkValue(taglist, val) is true
        hash = {}
        hash["name"] = val
        insertTag(hash)

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
      tag.prepend("<a href='#'><i class='fa fa-times'></i></a> &nbsp;")
      tag.append(field)
      $("#tag-list").prepend(tag)
      $("#tag-field").typeahead("setQuery", "")

    checkValue = (array, value) ->
      for data, i in array
        return true if data['name'] is value

  initTagger()

$(document).ready(ready)
$(document).on('page:load', ready)