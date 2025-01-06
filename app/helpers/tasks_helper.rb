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
end
