module CommentsHelper
  def comment_user comment, current_user
    comment.sender == current_user ? :sent : :received
  end

  def comment_delete_button comment, task
    return unless comment.sender == current_user

    button_to t("tasks.comment.delete"),
              task_comment_path(task, comment),
              method: :delete,
              data: {confirm: t("tasks.comment.confirm_delete")},
              class: "btn btn-danger btn-sm"
  end
end
