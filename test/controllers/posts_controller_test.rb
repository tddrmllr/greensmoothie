require 'test_helper'

class PostsControllerTest < ControllerTest
  class AdminUser < ControllerTest
    tests PostsController

    attr_accessor :blog_post

    setup do
      @blog_post = posts(:published_post)
      sign_in users(:admin_user)
    end

    test 'successful create' do
      post :create, post: { name: 'Test', description: 'Here is some meta text about this post. It needs to be 50 chars long.', body: 'Test text' }
      assert_redirected_to assigns(:post).named_route
    end

    test 'failed create' do
      post :create, post: { name: nil }
      assert_response 200
      assert_template :form
    end

    test 'destroy' do
      xhr :delete, :destroy, id: blog_post.id
      assert_response 200
      assert_equal 'Post deleted.', flash[:success]
    end

    test 'edit' do
      get :edit, id: blog_post.id
      assert_response :success
    end

    test 'index html' do
      get :index
      assert_response :success
    end

    test 'index js' do
      xhr :get, :index
      assert_response :success
      assert_template 'shared/index'
    end

    test 'new' do
      get :new
      assert_response :success
    end

    test 'show' do
      get :show, url_name: blog_post.url_name
      assert_response :success
    end

    test 'successful update' do
      put :update, id: blog_post.id, post: { name: 'New name' }
      assert_redirected_to blog_post.reload.named_route
      assert_equal 'New name', blog_post.reload.name
    end

    test 'failed update' do
      put :update, id: blog_post.id, post: { name: nil }
      assert_response 200
    end
  end

  class NoUser < ControllerTest
    tests PostsController

    attr_accessor :blog_post

    setup do
      @blog_post = posts(:published_post)
    end

    test 'create' do
      post :create
      assert_response :forbidden
    end

    test 'destroy' do
      xhr :delete, :destroy, id: blog_post.id
      assert_response :forbidden
    end

    test 'edit' do
      get :edit, id: blog_post.id
      assert_response :forbidden
    end

    test 'index' do
      get :index
      assert_response :success
    end

    test 'new' do
      get :new
      assert_response :forbidden
    end

    test 'show' do
      get :show, url_name: blog_post.url_name
      assert_response :success
    end

    test 'update' do
      put :update, id: blog_post.id, post: { name: 'New name' }
      assert_response :forbidden
    end
  end
end
