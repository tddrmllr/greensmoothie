class MailchimpController < ApplicationController
  require 'mailchimp'

  def subscribe
    @mailchimp = Mailchimp::API.new("fc59b4a51e93628dcc7152f899c97358-us8")
    begin
      @mailchimp.lists.subscribe(params[:id], {email: params[:email]}, {}, {}, double_optin: false)
      flash.now[:notice] = "Thanks for signing up! We've sent you a confirmation email, so check your inbox to complete the signup."
    rescue Mailchimp::ListAlreadySubscribedError
      flash.now[:error] = "#{params[:email]} is already subscribed."
    rescue Mailchimp::Error => ex
      if ex.message
        flash.now[:error] = ex.message
      else
        flash.now[:error] = "An unknown error occurred"
      end
    end
    render 'layouts/flasher'
  end
end
