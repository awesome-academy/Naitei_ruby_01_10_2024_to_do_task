class UpdateTasksAndTaskParticipants < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :creator_id, :bigint
    remove_column :tasks, :assignee_id, :bigint

    add_column :task_participants, :role, :string, null: false, default: 'assignee'

    add_index :task_participants, %i[task_id role], unique: true, where: "role = 'creator'"
  end
end
