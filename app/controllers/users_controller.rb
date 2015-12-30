class UsersController < ApplicationController

  load_and_authorize_resource

  def show
    @recipes = @user.recipes.page(params[:page]).per(10)
    @title = @user.username
  end

  def edit
    @title = "Edit Account"
    @delete = true
    render 'form'
  end

  def update
    if !user_params[:password].blank? && @user.update_attributes(user_params)
      flash[:success] = "Account updated."
      redirect_to @user
    elsif user_params[:password].blank? && @user.update_without_password(user_params)
      flash[:success] = "Account updated."
      redirect_to @user
    else
      @delete = true
      render 'form'
    end
  end

  def destroy
    sign_out(@user)
    @user.destroy
    flash[:success] = 'Account deleted.'
    @redirect = root_path
    render 'layouts/destroy'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation, :email_list, :image_token, :terms_of_service)
  end
end
