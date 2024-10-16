class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #=====ASSOCIATIONS====================================================================================================
  has_and_belongs_to_many :professions
  has_many :created_tasks, class_name: 'Task', foreign_key: 'created_by_user_id', dependent: :destroy
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assigned_to_user_id', dependent: :destroy
  has_many :discussions
  has_many :comments

  #=====VALIDATIONS=====================================================================================================
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

  #=====FILTERS=========================================================================================================
  def self.ransackable_attributes(auth_object = nil)
    %w[district experience_years full_name pin_code id]
  end

  def self.ransackable_associations(auth_object = nil)
    ["professions"]
  end

  #=====SCOPES==========================================================================================================
  scope :search_by_name, ->(query) {
    where('full_name ILIKE ?', "%#{query}%")
  }
  scope :exclude_current_user, ->(user) { where.not(id: user.id) }
  scope :average_rating, ->(user_id) {
    joins(assigned_tasks: :rating)
      .where(id: user_id)
      .average('ratings.rating')
      .to_f.round(2)
  }

  #=====METHODS=========================================================================================================
  def task_created_by_current_user?(current_user)
    assigned_tasks.where(created_by_user_id: current_user.id).exists?
  end

  # Calculate the user's average rating from tasks assigned to them
  def average_rating
    assigned_tasks.joins(:rating).average('ratings.rating') || 0.0
  end

  # Count the number of completed tasks
  def completed_tasks_count
    assigned_tasks.where(status: 'completed').count
  end

  # Combine completed tasks and average rating for leaderboard score
  def leaderboard_score
    (completed_tasks_count * 0.2) + (average_rating * 5)
  end

  # Calculate user's rank based on leaderboard score
  def user_rank
    User.all.sort_by(&:leaderboard_score).reverse.index(self) + 1
  end

  # Total number of users in the application
  def self.total_users
    User.count
  end

  private
  def must_have_at_least_one_profession
    if professions.empty?
      errors.add(:professions, "must have at least one profession")
    end
  end

end