require 'test_helper'

class PostTest < UnitTest
  attr_accessor :post

  setup do
    @post = posts(:published_post)
  end

  test 'named_route' do
    assert_equal '/blog/about-green-smoothies', post.named_route
  end

  test 'unpublished should include posts where published at is nil' do
    assert_includes Post.unpublished, Post.unscoped.find_by_url_name('being-vegan')
  end

  test 'published? should be true if published_at is present' do
    assert post.published?
  end

  test 'published? should be false if published_at is nil' do
    post.update_column :published_at, nil
    refute post.published?
  end

  test 'user' do
    assert_kind_of User, post.user
  end

  test 'sets url_name on save' do
    post.update_attributes(name: 'Green Smoothie Tools')
    assert_equal 'green-smoothie-tools', post.url_name
  end
end
