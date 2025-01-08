module TasksHelper
  def task_table_headers
    [
      t("tasks.index.table.title"),
      t("tasks.index.table.priority"),
      t("tasks.index.table.category"),
      t("tasks.index.table.status"),
      link_to(t("tasks.index.table.created_at"), "?sort=created_at"),
      link_to(t("tasks.index.table.deadline"), "?sort=deadline"),
      t("tasks.index.table.actions")
    ]
  end

  def priority_options
    Task.priorities.keys.map { |p| [ p.humanize, p ] }
  end

  def status_options
    Task.statuses.keys.map { |s| [ s.humanize, s ] }
  end

  def assignee_select(f, task, users, current_user)
    if current_user.mentor_role?
      f.select :assignee_id, options_from_collection_for_select(users, :id, :name, task.assignee_id), { include_blank: t("tasks.select_assignee") }, class: "form-control"
    elsif current_user.naitei_role?
      f.select :assignee_id, options_from_collection_for_select([ current_user ], :id, :name, task.assignee_id), { include_blank: t("tasks.select_assignee") }, class: "form-control"
    else
      f.select :assignee_id, [], { include_blank: t("tasks.select_assignee") }, class: "form-control"
    end
  end
end
