class GeneralMailer < ActionMailer::Base

  def support(email, message)
    @message = message
    @email = email
    mail(:to => 'support@greensmoothie.me', subject: 'Green Smoothie Contact Form', from: email)
  end
end
