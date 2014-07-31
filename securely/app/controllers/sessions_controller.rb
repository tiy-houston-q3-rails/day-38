class SessionsController < ApplicationController

  protect_from_forgery except: :api_login


  def new
  end

  def verify
    # find the user
    user = User.find_by email: params[:email]
    # check if password correct
    if user && user.authenticate(params[:password])
      sign_in user
    else
      render :new
    end
  end

  def register
    @user = User.new
  end

  def create_user
    @user = User.new params.require(:user).permit([:email, :name, :password, :password_confirmation])
    if @user.save
      sign_in @user
    else
      render :register
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  def sign_in user
    session[:user_id] = user.id
    redirect_to root_path
  end

  def api_signin
    # find the user
    user = User.find_by email: params[:email]
    # check if password correct
    if user && user.authenticate(params[:password])
      render json: user, status: 200
    else
      render text: "NOPE", status: 401
    end
  end
end
