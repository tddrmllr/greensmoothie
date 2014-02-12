class UsersController < ApplicationController

  before_filter :authorize, only: [:edit, :udate, :destroy]

  def show
    @user = User.find(params[:id])
    @title = @user.username
  end

  def edit
    @image = @user.image ||= @user.build_image
    @title = "Edit Account"
    render 'form'
  end

  def update
    if !user_params[:password].blank? && @user.update_attributes(user_params)
      flash[:notice] = "Account updated."
      redirect_to @user
    elsif user_params[:password].blank? && @user.update_without_password(user_params)
      flash[:notice] = "Account updated."
      redirect_to @user
    else
      @image = @user.image ||= @user.build_image
      render 'form'
    end
  end

  def destroy

  end

  private

  def authorize
    @user = User.find(params[:id])
    flash[:error] = "The page you attempted to view is unavailable."
    redirect_to current_user unless can? :manage, @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation, :recipes_email, :general_email, :image_token)
  end
end