module Unpublished
  class PostsController < ApplicationController

    before_filter :authenticate_user!

    def index
      authorize! :manage, Post
      @posts = Post.unpublished
      @title = 'Unpublished Posts'
      render 'posts/index'
    end
  end
end
