class SessionsController < ApplicationController

  before_action :require_logged_out, only: [:new]

  def new

  end

  def create
    @user = User.find_by(user_name: params[:user][:user_name])
    unless @user
      flash.now[:errors] = ["User does not exist"]
      render :new
      return
    end
    if @user.is_password?(params[:user][:password])
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["what have you done?!"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to cats_url
  end
end
