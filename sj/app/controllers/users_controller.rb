class UsersController < ApplicationController
  before_action :permission, :except => [:edit_password,:update_password]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user
      flash[:notice]= '添加成功!'
      redirect_to users_path
    else
      flash[:alert]= '添加失败!'
      render :new
    end
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '修改成功!'

      redirect_to users_path
    else
      flash[:alert] = '修改失败！'
    end
  end

  def edit_password
    @user = User.find(session[:user_id])
  end

  def update_password
    user = User.find_by(name:current_user.name).try(:authenticate,params[:oldpassword])
    if user
      if user.update_attributes(:password=>params[:password])
        flash[:notice] = "修改成功"
        redirect_to root_path
        session
      else
        flash[:alert] = "修改失败，请联系管理员"
        redirect_to editpwd_path
      end
    else
      flash[:alert] = "原密码输入错误，忘记密码请联系管理员"
      redirect_to editpwd_path

    end
  end
  def reset_password
    @user = User.find(params[:id])
    @user.update(:password=>"123456")
    flash[:notice] = "密码重置成功"
    redirect_to users_path
  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:name,:password, :usertype, :status, :datatype, :website, :description)
  end

  def permission
    if current_user.usertype != 1
      redirect_to root_path, :alert=>"没有权限"
    end
  end


end
