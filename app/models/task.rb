class Task < ApplicationRecord
  #=====ASSOCIATIONS====================================================================================================
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by_user_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assigned_to_user_id'
  has_one :rating, dependent: :destroy

  #=====ENUMS===========================================================================================================
  enum status: { created: 0, viewed: 1, accepted: 2, in_progress: 3, completed: 4, cancelled: 5 }
  enum priority: { low: 0, medium: 1, high: 2 }

  #=====VALIDATIONS=====================================================================================================
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates :priority, presence: true
  validates :due_date, presence: true
  validate :assignee_is_not_creator
  validate :status_transition_is_valid

  #=====FILTERS=========================================================================================================
  def self.ransackable_attributes(auth_object = nil)
    %w[created_by_user_id assigned_to_user_id created_at due_date priority status]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[creator assignee]
  end

  #=====CALLBACKS=======================================================================================================
  before_create :set_default_status
  before_save :set_completion_date, if: :status_changed_to_completed?

  #=====SCOPES==========================================================================================================
  scope :tasks_completed, ->(user) { where(assigned_to_user_id: user.id, status: 'completed').count }

  private
  def assignee_is_not_creator
    if assignee == creator
      errors.add(:assignee, "can't be the same as the creator")
    end
  end

  def set_default_status
    self.status ||= :created
  end

  def status_transition_is_valid
    if status_changed? && status_was.present?
      valid_transitions = {
        "created" => ["viewed"],
        "viewed" => ["accepted", "cancelled"],
        "accepted" => ["in_progress"],
        "in_progress" => ["completed"],
        "completed" => [],
        "cancelled" => []
      }

      unless valid_transitions[status_was].include?(status)
        errors.add(:status, "cannot transition from #{status_was.humanize} to #{status.humanize}")
      end
    end
  end

  def status_changed_to_completed?
    status_changed? && status == 'completed'
  end

  def set_completion_date
    self.completion_date = Time.current
  end
end
