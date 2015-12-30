module Support
  class MessagesController < ApplicationController
    def create
      if params[:email].present? && params[:message].present?
        SupportMailer.contact_form(params).deliver
        flash.now[:success] = "Your message was sent! We'll respond as soon as we can."
      else
        flash.now[:error] = "Please fill out all the fields."
      end
    end
  end
end
