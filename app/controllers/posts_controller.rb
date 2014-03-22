class PostsController < ApplicationController

  authorize_resource

  include UpdateImage
  include UpdateTags
  include Searchable

  def index
    @title = "The Green Smoothie Blog"
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @title = @post.name
  end

  def new
    @post = Post.new
    @image = @post.build_image
    @title = "New Post"
    render 'form'
  end

  def edit
    @post = Post.find(params[:id])
    @image = @post.image ||= @post.build_image
    @title = "Edit Post"
    render 'form'
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post.named_route
    else
      @image = @post.image ||= @post.build_image
      render 'form'
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)
    if @post.save
      redirect_to @post.named_route
      flash[:notice] = "Post saved successfully."
    else
      @image = @post.image ||= @post.build_image
      render 'form'
    end
  end

  def core_content
    name = request.url.gsub(HOST + "/", "")
    @post = Post.core.select {|x| x.dashed_name == name}.first
    @comments = @post.comments
    @title = @post.name
    render 'show'
  end

  private

  def post_params
    params.require(:post).permit(:name, :body, :abstract, :user_id, :headline, :core_content)
  end
end