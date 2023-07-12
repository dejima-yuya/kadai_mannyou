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

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
