require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let!(:task) { create(:task, creator: user) }

  before { sign_in user }

  describe "GET #created" do
    it "returns a successful response" do
      get :created
      expect(response).to have_http_status(:ok)
      expect(assigns(:created_tasks)).to include(task)
    end

    it "redirects to login when not authenticated" do
      sign_out user
      get :created
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #new" do
    let(:other_user) { create(:user) }

    it "assigns the correct assignee when user_id is provided" do
      get :new, params: { user_id: other_user.id }
      expect(assigns(:assignee)).to eq(other_user)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:assignee) { create(:user) }

    it "creates a new task and redirects" do
      expect {
        post :create, params: { task: attributes_for(:task, assigned_to_user_id: assignee.id) }
      }.to change(Task, :count).by(1)
      expect(response).to redirect_to(task_path(assigns(:task)))
      expect(flash[:notice]).to eq("Task was successfully created.")
    end

    it "does not create a task with invalid attributes" do
      expect {
        post :create, params: { task: attributes_for(:task, title: nil) }
      }.not_to change(Task, :count)
      expect(response).to render_template(:new)
      expect(assigns(:task).errors[:title]).to include("can't be blank")
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      task = create(:task, creator: user)
      get :show, params: { id: task.id }
      expect(response).to have_http_status(:ok)
    end

    it "updates the task status to viewed when assigned to the current user" do
      task = create(:task, assignee: user, status: :created)
      get :show, params: { id: task.id }
      task.reload
      expect(task.status).to eq("viewed")
    end
  end
end