class PagesController < ApplicationController
  def home
    @title = "Green Smoothie"
  end

  def learn
    @title = "What Is Green Smoothie?"
  end
end
