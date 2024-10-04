require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, user_name: 'otheruser', email: 'other@example.com') }

  before do
    sign_in user
  end

  describe "GET #index" do
    login_user
    it "assigns users excluding the current user" do
      get :index
      expect(assigns(:users)).to include(other_user)
      expect(assigns(:users)).not_to include(subject.current_user)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "paginates users" do
      allow(controller).to receive(:pagy).and_return([nil, [user, other_user]])
      get :index
      expect(assigns(:users)).to eq([user, other_user])
    end
  end

  describe "GET #show" do
    login_user
    it "assigns the requested user" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it "calculates the average rating for the user" do
      allow(User).to receive(:average_rating).with(user.id).and_return(4.5)
      get :show, params: { id: user.id }
      expect(assigns(:average_rating)).to eq(4.5)
    end

    it "renders the show template" do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end

    it "returns a 404 if the user is not found" do
      expect {
        get :show, params: { id: 999 }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "GET #search" do
    it "returns users matching the search query" do
      get :search, params: { q: user.full_name }, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first['full_name']).to eq(user.full_name)
    end

    it "returns an empty result if no users are found" do
      get :search, params: { q: 'nonexistent' }, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_empty
    end
  end
end
