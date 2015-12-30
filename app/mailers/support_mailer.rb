class SupportMailer < ActionMailer::Base

  def contact_form(params)
    @message = params[:message]
    @email = params[:email]
    mail(:to => 'support@greensmoothie.me', subject: 'Green Smoothie Contact Form', from: @email)
  end
end
