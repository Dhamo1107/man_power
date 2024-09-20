class Comment < ApplicationRecord
  #=====ASSOCIATIONS====================================================================================================
  belongs_to :discussion
  belongs_to :user

  #=====VALIDATIONS=====================================================================================================
  validates :body, presence: true
end
