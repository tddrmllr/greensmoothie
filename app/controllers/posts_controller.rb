class PostsController < ApplicationController

  authorize_resource

  include UpdateImage
  include Searchable

  def index
    @title = "The Green Smoothie Blog"
  end

  def show
    @post = Post.unscoped.find_by_url_name(params[:url_name])
    @title = @post.name
  end

  def new
    @post = Post.new(user_id: current_user.id)
    @title = "New Post"
    render 'form'
  end

  def edit
    @post = Post.unscoped.find(params[:id])
    @title = "Edit Post"
    @delete = true
    render 'form'
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post.named_route
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
      redirect_to @post.named_route
      flash[:success] = "Post saved successfully."
    else
      @delete = true
      render 'form'
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :body, :abstract, :user_id, :headline, :published_at)
  end
end
