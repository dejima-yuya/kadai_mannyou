class TasksController < ApplicationController
  def index
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = Task.search_title_status(params[:task][:title], params[:task][:status]).page(params[:page]).per(5)
      elsif params[:task][:title].present?
        @tasks = Task.search_title(params[:task][:title]).page(params[:page]).per(5)
      elsif params[:task][:status].present?
        @tasks = Task.search_status(params[:task][:status]).page(params[:page]).per(5)
      else
        @tasks = Task.all.order(created_at: :DESC).page(params[:page]).per(5)
      end
    elsif params[:sort_expired]
      @tasks = Task.all.order(end_date: :DESC).page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :ASC).page(params[:page]).per(5)
    else
      @tasks = Task.all.order(created_at: :DESC).page(params[:page]).per(5)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task), notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :end_date, :status, :priority)
  end
end
