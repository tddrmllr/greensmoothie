$("#comments").prepend("<%= escape_javascript(render @comment) %>")
$("#comment").val("")
