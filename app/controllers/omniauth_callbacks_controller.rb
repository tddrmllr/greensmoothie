class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    auth = request.env["omniauth.auth"]
    authentication = Authentication.where(provider: auth.provider, uid: auth.uid).first
    if authentication
      flash.notice = "Signed in successfully."
      sign_in authentication.user
      redirect_to user_path(current_user)
    elsif current_user
      current_user.authentications.create(provider: auth.provider, uid: auth.uid)
      flash.notice = "Authentication successful."
      redirect_to user_path(current_user)
    else
      user = User.new
      user.apply_omniauth(auth)
      if user.save
        flash.notice = "Signed in successfully."
        sign_in user
        redirect_to edit_user_path(current_user, signup: true)
      else
        flash[:error] = "Unable to authenticate."
        redirect_to new_user_session_path
      end
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all

end