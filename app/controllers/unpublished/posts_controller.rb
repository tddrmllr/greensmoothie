module Unpublished
  class PostsController < ApplicationController

    before_filter :authenticate_user!, :authorize_user

    def index
      authorize! :manage, Post
      @posts = Post.unpublished
      @title = 'Unpublished Posts'
    end

    def show
      @post = Posts::ShowPresenter.new(url_name: params[:id])
      render 'posts/show'
    end

    private

    def authorize_user
      authorize! :manage, Post
    end
  end
end
