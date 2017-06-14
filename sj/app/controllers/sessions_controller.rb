class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(name:params[:name]).try(:authenticate,params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:alert] = '登录失败!'
      redirect_to new_session_path
    end
  end

  private
  def user_params
    params.require(:session).permit(:name, :password)
  end

end
