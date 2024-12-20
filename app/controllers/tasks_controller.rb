class TasksController < ApplicationController
  before_action :set_task, only: %i[destroy]

  def new; end

  def index
    @tasks = Task.by_user current_user
    @categories = Category.all
    @tasks = @tasks.filter_by_category(params[:category])
                  .filter_by_status(params[:status])
                  .filter_by_deadline(params[:deadline])

    @pagy, @tasks = pagy @tasks, items: Settings.default.tasks_per_page_5
  end

  def edit; end

  def destroy
    if @task.destroy
      flash[:success] = t "tasks.task_deleted"
      redirect_to request.referer || tasks_url, status: :see_other
    else
      flash[:error] = t "tasks.failed_to_delete_the_task"
      redirect_to tasks_url
    end
  end

  private
  def set_task
    @task = Task.find_by(id: params[:id])
    return if @task

    flash[:error] = t "tasks.not_found"
    redirect_to tasks_url, status: :see_other
  end
end
