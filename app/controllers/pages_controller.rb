class PagesController < ApplicationController
  def contact
    @title = "Contact Us"
  end

  def home
    @title = "Green Smoothie"
  end

  def privacy
    @title = "Privacy Policy"
  end

  def terms
    @title = "Terms of Service"
  end
end
