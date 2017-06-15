class SessionsController < ApplicationController

  skip_before_action :user_authenticate

  def new
   render layout: nil
  end

  def create
    user = User.find_by(name:params[:name]).try(:authenticate,params[:password])
      if user
        if user.status == true
          session[:user_id] = user.id
          flash[:notice] = '登录成功'
          redirect_to root_path
        else
          flash[:alert] = '账户已停用!'
          redirect_to new_session_path
        end
      else
        flash[:alert] = '登录失败!'
        redirect_to new_session_path
      end
  end
  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, :alert => "退出成功"
  end

  private
  def user_params
    params.require(:session).permit(:name, :password)
  end

end
