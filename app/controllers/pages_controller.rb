class PagesController < ApplicationController
  def home
    @title = "Green Smoothie"
  end

  def basics
    @title = "Green Smoothie Basics"
  end

  def making
    @title = "Making Green Smoothies"
  end

  def tools
    @title = "Green Smoothie Tools"
  end
end
