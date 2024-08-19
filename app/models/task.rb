class Task < ApplicationRecord
  #=====ASSOCIATIONS====================================================================================================
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by_user_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assigned_to_user_id'

  #=====ENUMS===========================================================================================================
  enum status: { start: 0, in_progress: 1, completed: 2, cancelled: 3 }

  #=====VALIDATIONS=====================================================================================================
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :status, inclusion: { in: statuses.keys }
end
