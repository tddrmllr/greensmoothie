class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    render 'form'
  end

  def edit
    @post = Post.find(params[:id])
    render 'form'
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
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
      render 'form'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :abstract, :user_id)
  end
end