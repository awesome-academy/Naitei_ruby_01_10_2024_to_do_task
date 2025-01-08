class SubtasksController < ApplicationController
  before_action :set_task

  def create
    @subtask = current_user.tasks.build subtask_params
    if @subtask.save
      flash[:success] = t "tasks.new.subtask_created_successfully"
      redirect_to edit_task_path @task
    else
      flash[:alert] = @subtask.errors.full_messages.to_sentence
    end
  end

  private

  def subtask_params
    params.require(:task).permit(Task::SUBTASK_PERMITTED_ATTRIBUTES)
  end

  def set_task
    @task = Task.find params[:task_id]
  end
end
