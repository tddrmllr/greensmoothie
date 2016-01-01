module DisqusHelper
  def disqus_comments(disqusable)
    content_tag :div, nil, id: 'disqus_thread', data: { id: disqusable.disqus_id, title: disqusable.name }
  end
end
