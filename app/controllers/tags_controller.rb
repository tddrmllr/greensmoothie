class TagsController < ApplicationController

  def index
    @taggables = ActsAsTaggableOn::Tagging.select {|x| x.tag.name == params[:name]}.map {|x| x.taggable}
  end
end