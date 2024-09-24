class Comment < ApplicationRecord
  #=====ASSOCIATIONS====================================================================================================
  belongs_to :discussion, counter_cache: true
  belongs_to :user

  #=====VALIDATIONS=====================================================================================================
  validates :body, presence: true
end
