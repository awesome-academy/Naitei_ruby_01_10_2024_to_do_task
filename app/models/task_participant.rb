class TaskParticipant < ApplicationRecord
  belongs_to :task
  belongs_to :user

  enum role: Settings.default.task_participant_roles.symbolize_keys

  validates :role, presence: true
end
