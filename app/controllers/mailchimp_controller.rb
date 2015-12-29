class MailchimpController < ApplicationController
  require 'mailchimp'

  def subscribe
    if Mailchimp::Subscribe.run(params)
      flash.now[:success] = "Thanks for signing up! We'll keep you up to date with the freshest green smoothie content."
    else
      flash.now[:error] = "Sorry, an error occurred."
    end
    render 'layouts/flasher'
  end
end
