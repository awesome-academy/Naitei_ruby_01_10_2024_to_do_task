class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  attr_accessor :remember_token, :activation_token, :reset_token

  USER_PERMITTED_ATTRIBUTES = %i[name email password].freeze

  has_many :created_tasks, class_name: "Task", foreign_key: :creator_id, dependent: :destroy
  has_many :assigned_tasks, class_name: "Task", foreign_key: :assignee_id, dependent: :nullify
  has_many :categories, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :task_participants, dependent: :destroy
  has_many :participated_tasks, through: :task_participants, source: :task

  enum role: Settings.default.roles.to_h.transform_keys(&:to_sym)

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { maximum: Settings.default.username_max_length_100 }
  validates :role, presence: true

  before_save :downcase_email

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
      BCrypt::Password.create(string, cost:)
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
    remember_digest
  end

  def authenticated?(attribute, token)
    digest = send "#{attribute}_digest"
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password? token
  end

  def session_token
    remember_digest || remember
  end

  def forget
    update_attribute :remember_digest, nil
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
