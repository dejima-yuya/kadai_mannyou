class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def index
    @users = User.select(:id, :name, :email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザーを作成しました'
      render :new
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_admin_user_path, notice: "ユーザーを編集しました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
