require 'test_helper'

module Unpublished
  class PostsControllerTest < ControllerTest
    attr_accessor :unpublished_post

    setup do
      @unpublished_post = Post.unpublished.first
    end

    class AdminUser < PostsControllerTest
      setup do
        sign_in users(:admin_user)
      end

      test 'index' do
        get :index
        assert_response :success
      end

      test 'show' do
        get :show, id: unpublished_post.url_name
        assert_response :success
        assert_template 'posts/show'
      end
    end

    class NormalUser < PostsControllerTest
      setup do
        sign_in users(:normal_user)
      end

      test 'index' do
        get :index
        assert_response :forbidden
      end

      test 'show' do
        get :show, id: unpublished_post.url_name
        assert_response :forbidden
      end
    end

    class NoUser < PostsControllerTest
      test 'index' do
        get :index
        assert_response 302
      end

      test 'show' do
        get :show, id: unpublished_post.url_name
        assert_response 302
      end
    end
  end
end
