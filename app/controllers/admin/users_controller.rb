class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :admin_user

  def index
    @users = User.select(:id, :name, :email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザーを作成しました！"
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
      redirect_to admin_user_path(@user), notice: "ユーザーを編集しました！"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました！"
    else
      redirect_to admin_users_path, notice: '管理者は最低一人は必要な為、削除できません！'
    end
  end

  def grant_admin
    @user = User.find(params[:id])
    if @user.update(admin: true)
      redirect_to admin_users_path, notice: '管理者権限を付与しました！'
    else
      redirect_to admin_users_path
    end
  end

  def deprive_admin
    @user = User.find(params[:id])
    if @user.update(admin: false)
      redirect_to admin_users_path, notice: '管理者権限を解除しました！'
    else
      redirect_to admin_users_path, notice: '管理者は最低一人は必要な為、管理者権限を解除することが出来ません！'
    end
  end
  
  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_user
    unless current_user.admin?
      redirect_to tasks_path, notice: "管理者以外はアクセスできません！"
    end
  end
end
