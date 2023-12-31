class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    if logged_in?
      redirect_to user_path(@current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'アカウントを作成しました！'
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
    if @user.id != current_user.id
      redirect_to tasks_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
