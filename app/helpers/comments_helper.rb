module CommentsHelper

  def comment_count(commentable)
    if commentable.comments.any?
      "&nbsp;<span class='badge comment-count'>#{commentable.comments.count}</span>".html_safe
    end
  end
end
