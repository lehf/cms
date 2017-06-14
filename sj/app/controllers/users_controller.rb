class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to users_index_path
    end
  end

  def edit
  end
  private
  def user_params
    params.require(:user).permit(:name,:type,:status,:datatype,:website,:description)
  end
end
