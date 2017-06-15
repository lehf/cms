class BaseController < ApplicationController
  layout "base"


  def current_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end

  private
  def user_authenticate
    unless session[:user_id]
      redirect_to new_session_path, :alert=>"请先登录！"
    end
  end
end
