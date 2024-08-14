class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #=====VALIDATIONS====================================================================================================
  validates :full_name, presence: true
  validates :user_name, presence: true, uniqueness: true, length: { in: 6..20 }
  validates_format_of :user_name, with: /\A[a-z0-9_]+\z/,
                      message: "can only contain lowercase letters, numbers, and underscores"
  # validates :password, presence: true, length: { minimum: 6 }
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }
  validates :date_of_birth, presence: true
  validates :profession, presence: true
  validates :experience_years, presence: true
  validates :address, presence: true
  validates :district, presence: true
  validates :pin_code, presence: true, format: { with: /\A\d{6}\z/, message: "must be a 6-digit number" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true

end
