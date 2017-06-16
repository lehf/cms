class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :user_authenticate

  def current_user
    session[:user_id] ?   User.find(session[:user_id]) : nil
  end

  private
  def user_authenticate
    unless session[:user_id]
      redirect_to new_session_path, :alert=>"请先登录！"
    end
  end

end
