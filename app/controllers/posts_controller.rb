class PostsController < ApplicationController

  authorize_resource

  include UpdateImage

  def index
    @posts = Posts::IndexPresenter.new(params: params, per: 8)
    respond_to do |format|
      format.js { render 'shared/index' }
      format.html
    end
  end

  def show
    @post = Posts::ShowPresenter.new(url_name: params[:url_name])
  end

  def new
    @post = Post.new(user_id: current_user.id)
    @title = "New Post"
    render 'form'
  end

  def edit
    @post = Post.unscoped.find(params[:id])
    @title = "Edit Post"
    render 'form'
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to after_save_path(@post)
    else
      render 'form'
    end
  end

  def destroy
    @post = Post.unscoped.find(params[:id])
    @post.destroy
    flash[:success] = "Post deleted."
    @redirect = blog_path
    render 'layouts/destroy'
  end

  def update
    @post = Post.unscoped.find(params[:id])
    @post.update_attributes(post_params)
    if @post.save
      redirect_to after_save_path(@post)
      flash[:success] = "Post saved successfully."
    else
      render 'form'
    end
  end

  private

  def after_save_path(post)
    post.published? ? post.named_route : "/unpublished/posts/#{post.url_name}"
  end

  def post_params
    params.require(:post).permit(:name, :body, :description, :user_id, :headline, :published_at)
  end
end
