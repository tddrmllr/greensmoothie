class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :username
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def popular_recipes
    @popular_recipes ||= Recipe.order(rating: :asc).limit(3)
  end

  protected

  def username
    if user_signed_in? && controller_name != "users" && action_name != "edit" && controller_name != "images"
      if current_user.username.blank?
        @user = current_user
        if @user.save
          flash[:notice] = "Account updated."
          redirect_to @user
        else
          @image = @user.image ||= @user.build_image
          render 'users/form'
        end
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

end
