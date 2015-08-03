class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    elsif @user && @user.authenticate(params[:session][:password]) == false
      flash[:error] = "Your password was entered incorrectly"
      redirect_to login_path
    else
      flash[:error] = "That username is not in our database"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:logout] = "Logged out"
    redirect_to root_path
  end
end