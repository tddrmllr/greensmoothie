$("#comment-<%= escape_javascript(@comment.id.to_s) %>").remove()
