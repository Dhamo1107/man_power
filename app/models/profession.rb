class Profession < ApplicationRecord
  #=====ASSOCIATIONS====================================================================================================
  has_and_belongs_to_many :users

  #=====SCOPES====================================================================================================
  scope :search_by_name, ->(query) {
    where('name ILIKE ?', "%#{query}%")
  }
end
