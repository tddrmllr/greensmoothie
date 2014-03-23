class UsersController < ApplicationController

  before_filter :authorize, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page]).per(10)
    @title = @user.username
    flash[:notice] = "Flash it"
  end

  def edit
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
      render 'form'
    end
  end

  def destroy

  end

  private

  def authorize
    @user = User.find(params[:id])
    if cannot? :manage, @user
      flash[:error] = "The page you attempted to view is unavailable."
      redirect_to current_user
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation, :email_list, :image_token)
  end
end