class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :check_user
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :mobile_device?

  rescue_from CanCan::AccessDenied do |exception|
    @title = 'Error'
    render 'layouts/forbidden', status: :forbidden
  end

  protected

  def check_user
    if user_signed_in? && controller_name != "users" && action_name != "edit" && controller_name != "images" && controller_name != "sessions"
      if current_user.email.blank? || current_user.username.blank? || !current_user.terms_of_service
        @user = current_user
        if @user.save
          flash[:success] = "Account updated."
          redirect_to @user
        else
          render 'users/form'
        end
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :terms_of_service) }
  end

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end

end
