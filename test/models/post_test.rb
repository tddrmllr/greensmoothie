require 'test_helper'

class PostTest < UnitTest
  attr_accessor :post

  setup do
    @post = posts(:admin_post)
  end

  test 'named_route' do
    assert_equal '/blog/about-green-smoothies', post.named_route
  end

  test 'user' do
    assert_kind_of User, post.user
  end

  test 'sets url_name on save' do
    post.update_attributes(name: 'Green Smoothie Tools')
    assert_equal 'green-smoothie-tools', post.url_name
  end
end
