FactoryBot.define do
  factory :task do
    title { "Sample Task" }
    description { "This is a sample task description." }
    priority { :medium }
    status { :created }
    due_date { 2.days.from_now }
    association :creator, factory: :user
    association :assignee, factory: :user
  end
end