class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :task, optional: true

  enum action: Settings.default.actions.to_h.transform_keys(&:to_sym)

  validates :action, presence: true
  validates :description, length: { maximum: Settings.default.comment_max_length_10_000 }, allow_blank: true
end
