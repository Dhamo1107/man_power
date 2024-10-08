require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:creator) { create(:user) }
  let(:assignee) { create(:user) }

  it "is valid with valid attributes" do
    task = build(:task, creator: creator, assignee: assignee)
    expect(task).to be_valid
  end

  it "allows valid status transitions" do
    task = create(:task, creator: creator, assignee: assignee, status: "created")
    task.update(status: "viewed")
    expect(task.status).to eq("viewed")
  end

  it "is invalid if the assignee is the same as the creator" do
    task = build(:task, creator: creator, assignee: creator)
    expect(task).to be_invalid
    expect(task.errors[:assignee]).to include("can't be the same as the creator")
  end

  it "does not allow invalid status transitions" do
    task = create(:task, creator: creator, assignee: assignee, status: "completed")
    task.update(status: "in_progress")
    expect(task.errors[:status]).to include("cannot transition from Completed to In progress")
  end
end