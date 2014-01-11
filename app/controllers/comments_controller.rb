class CommentsController < ApplicationController

  authorize_resource

  before_filter :commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      render 'create'
    else
      flash.now[:error] = "There was an error saving your comment."
      render 'layouts/flasher'
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
  end

  private

  def commentable
    entity_param = params.select {|x| x.index("_id")}.first
    entity_type = entity_param.first.gsub("_id","")
    @commentable = entity_type.classify.constantize.find(entity_param.last)
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
