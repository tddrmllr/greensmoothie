class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :username, :popular_recipes

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

end
