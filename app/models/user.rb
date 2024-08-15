class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #=====ASSOCIATIONS====================================================================================================
  has_and_belongs_to_many :professions

  #=====VALIDATIONS====================================================================================================
  validates :full_name, presence: true
  validates :user_name, presence: true, uniqueness: true, length: { in: 6..20 }
  validates_format_of :user_name, with: /\A[a-z0-9_]+\z/,
                      message: "can only contain lowercase letters, numbers, and underscores"
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }
  validates :date_of_birth, presence: true
  validates :experience_years, presence: true
  validates :address, presence: true
  validates :district, presence: true
  validates :pin_code, presence: true, format: { with: /\A\d{6}\z/, message: "must be a 6-digit number" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validate :must_have_at_least_one_profession

  #=====FILTERS====================================================================================================
  def self.ransackable_attributes(auth_object = nil)
    %w[district experience_years full_name pin_code]
  end

  def self.ransackable_associations(auth_object = nil)
    ["professions"]
  end

  private
  def must_have_at_least_one_profession
    if professions.empty?
      errors.add(:professions, "must have at least one profession")
    end
  end

end
