require 'test_helper'

class DisqusHelperTest < HelperTest
  include DisqusHelper

  test 'disqus_comments' do
    disqusable = posts(:admin_post)
    html = Nokogiri::HTML.fragment(disqus_comments(disqusable)).children.first
    assert_equal 'disqus_thread', html.attr('id')
    assert_equal "post-#{disqusable.id}", html.attr('data-id')
    assert_equal 'About Green Smoothies', html.attr('data-title')
  end
end
