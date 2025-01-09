class CommentsController < ApplicationController
  before_action :set_task
  before_action :set_comment, only: %i(destroy)

  def create
    @comment = @task.comments.build comment_params
    @comment.sender = current_user

    if @comment.save
      redirect_to @task
    else
      flash[:alert] = t "tasks.comment.failed_to_add_comment"
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "tasks.comment.comment_deleted_successfully"
    else
      flash[:alert] = t "tasks.comment.failed_to_delete_comment"
    end
    redirect_to @task
  end

  private

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PERMITTED_ATTRIBUTES
  end

  def set_task
    @task = Task.find params[:task_id]
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t "tasks.not_found"
    redirect_to tasks_path
  end

  def set_comment
    @comment = @task.comments.find params[:id]
  end
end
