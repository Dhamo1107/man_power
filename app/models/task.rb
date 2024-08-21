class Task < ApplicationRecord
  #=====ASSOCIATIONS====================================================================================================
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by_user_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assigned_to_user_id'

  #=====ENUMS===========================================================================================================
  enum status: { created: 0, viewed: 1, in_progress: 2, completed: 3, cancelled: 4 }

  #=====VALIDATIONS=====================================================================================================
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validate :assignee_is_not_creator

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
end
