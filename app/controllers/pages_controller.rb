class PagesController < ApplicationController
  def home
    @title = "Green Smoothie"
  end

  def about
    @title = "About Green Smoothie"
  end
end
