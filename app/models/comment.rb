class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :sender, class_name: "User", foreign_key: "user_id"
  COMMENT_PERMITTED_ATTRIBUTES = %i(content).freeze

  validates :content, presence: true,
            length: {maximum: Settings.default.comment_max_length_10_000}
end
