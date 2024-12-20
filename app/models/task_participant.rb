class TaskParticipant < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :role, presence: true, inclusion: { in: Settings.default.task_roles }
end
