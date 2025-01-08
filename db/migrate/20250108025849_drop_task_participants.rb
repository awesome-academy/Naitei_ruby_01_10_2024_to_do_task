class DropTaskParticipants < ActiveRecord::Migration[6.0]
  def up
    drop_table :task_participants if table_exists?(:task_participants)
  end

  def down
    create_table :task_participants do |t|
      t.bigint "task_id", null: false
      t.bigint "user_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "role", default: "assignee", null: false
      t.index [ "task_id", "role" ], name: "index_task_participants_on_task_id_and_role", unique: true
      t.index [ "task_id" ], name: "index_task_participants_on_task_id"
      t.index [ "user_id" ], name: "index_task_participants_on_user_id"
    end
  end
end
