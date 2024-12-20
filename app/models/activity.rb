class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :task, optional: true

  validates :activity_type, presence: true
  validates :description, length: { maximum: Settings.default.comment_max_length_10_000 }, allow_blank: true
end
