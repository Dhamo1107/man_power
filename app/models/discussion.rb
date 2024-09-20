class Discussion < ApplicationRecord
  #=====ASSOCIATIONS====================================================================================================
  belongs_to :user
  has_many :comments, dependent: :destroy

  #=====VALIDATIONS=====================================================================================================
  validates :title, presence: true
  validates :body, presence: true
end
