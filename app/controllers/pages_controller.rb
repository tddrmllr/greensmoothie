class PagesController < ApplicationController
  def home
    @title = "Green Smoothie"
  end

  def learn
    @title = "What Is Green Smoothie?"
  end

  def basics
    @title = "Green Smoothie Basics"
  end

  def tools
    @title = "Green Smoothie Tools"
  end
end
