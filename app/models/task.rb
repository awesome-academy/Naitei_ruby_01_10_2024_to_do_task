class Task < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true
  belongs_to :category, optional: true
  belongs_to :parent_task, class_name: "Task", optional: true
  has_many :sub_tasks, class_name: "Task", foreign_key: :parent_task_id, dependent: :destroy
  has_many :task_participants, dependent: :destroy
  has_many :participants, through: :task_participants, source: :user
  has_many :comments, dependent: :destroy
  has_many :activities, dependent: :destroy

  enum priority: Settings.default.prioritiesto_h.transform_keys(&:to_sym)
  enum status: Settings.default.statusto_h.transform_keys(&:to_sym)

  validates :title, presence: true, length: { maximum: Settings.default.task_title_max_length }
  validates :priority, presence: true
  validates :status, presence: true
  validates :deadline, comparison: { greater_than: :start_date, allow_blank: true }, if: :start_date?

  scope :by_priority, ->(priority) { where(priority: priorities[priority]) }
  scope :by_status, ->(status) { where(status: statuses[status]) }
end
