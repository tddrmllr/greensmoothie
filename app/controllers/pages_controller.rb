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

  def support
    if params[:email].present? && params[:message].present?
      GeneralMailer.support(params[:email], params[:message]).deliver
      flash.now[:success] = "Your message was sent. We'll respond as soon as we can!"
    else
      flash.now[:error] = "Please fill out all the fields."
    end
  end

  def terms
    @title = "Terms of Service"
  end

  def test

  end




end
