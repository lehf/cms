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
    if current_user.usertype == 1
      @user = User.find(params[:id])
    else
      redirect_to root_path, :alert => "没有权限"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '修改成功!'

      redirect_to users_path
    end
  end

  def edit_password

  end
  def update_password

  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:name,:password, :usertype, :status, :datatype, :website, :description)
  end

  def permission
    if current_user.usertype != 1
      redirect_to root_path, :alert=>"权限不足"
    end
  end
end
