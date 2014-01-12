class PostsController < ApplicationController

  authorize_resource

  include UpdateImage
  include UpdateTags

  def index
    @posts = Post.all
    @title = "Green Smoothie Blog"
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @title = @post.name
  end

  def new
    @post = Post.new
    @image = @post.build_image
    render 'form'
  end

  def edit
    @post = Post.find(params[:id])
    @image = @post.image ||= @post.build_image
    render 'form'
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      @image = @post.image ||= @post.build_image
      render 'form'
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)
    if @post.save
      redirect_to @post
      flash[:notice] = "Post saved successfully."
    else
      @image = @post.image ||= @post.build_image
      render 'form'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :abstract, :user_id)
  end
end