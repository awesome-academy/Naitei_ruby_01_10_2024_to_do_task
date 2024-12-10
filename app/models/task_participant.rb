class TaskParticipant < ApplicationRecord
  belongs_to :task
  belongs_to :user

  enum role: Settings.default.task_participant_rolesto_h.transform_keys(&:to_sym)

  validates :role, presence: true
end
