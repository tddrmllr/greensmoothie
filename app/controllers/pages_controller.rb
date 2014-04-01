class PagesController < ApplicationController
  def home
    @title = "Green Smoothie"
  end

  def test

  end

  def terms
    @title = "Terms of Service"
  end

  def privacy
    @title = "Privacy Policy"
  end
end
