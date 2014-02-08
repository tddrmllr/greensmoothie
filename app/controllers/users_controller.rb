class UsersController < ApplicationController

  authorize_resource

  def show
    @user = User.find(params[:id])
    @title = "Your Account"
  end

  def edit
    @user = User.find(params[:id])
    @image = @user.image ||= @user.build_image
    @title = "Edit Account"
    render 'form'
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Account updated."
      redirect_to @user
    else
      @image = @user.image ||= @user.build_image
      render 'form'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation, :recipes_email, :general_email)
  end
end