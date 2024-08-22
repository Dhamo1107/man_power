class Task < ApplicationRecord
  #=====ASSOCIATIONS====================================================================================================
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by_user_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assigned_to_user_id'

  #=====ENUMS===========================================================================================================
  enum status: { created: 0, viewed: 1, accepted: 2, in_progress: 3, completed: 4, cancelled: 5 }

  #=====VALIDATIONS=====================================================================================================
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validate :assignee_is_not_creator
  validate :status_transition_is_valid

  #=====CALLBACKS=======================================================================================================
  before_create :set_default_status

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
end
