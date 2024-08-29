class Rating < ApplicationRecord
  #=====ASSOCIATIONS====================================================================================================
  belongs_to :task

  #=====VALIDATIONS=====================================================================================================
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, length: { maximum: 100 }
end
