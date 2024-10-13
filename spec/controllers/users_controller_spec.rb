require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:current_user) { create(:user) }
  let!(:other_users) { create_list(:user, 20) }

  before do
    sign_in current_user
  end

  describe "GET #index" do
    context "when the current user is not logged in" do
      before do
        sign_out current_user
      end

      it "redirects to the login page with a flash message" do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    context "when user is logged in" do
      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:ok)
      end

      it "excludes the current user from the list" do
        get :index
        users = assigns(:users)
        expect(users).not_to include(current_user)
        expect(response).to have_http_status(:ok)
      end

      it "displays the first page of users with 9 users" do
        get :index, params: { page: 1 }
        users = assigns(:users)
        pagy = assigns(:pagy)
        expect(pagy.page).to eq(1)
        expect(users.count).to eq(9)
        expect(users.map(&:id)).to eq(User.offset(0).limit(9).pluck(:id))
        expect(response).to have_http_status(:ok)
      end

      it "displays the second page of users with 9 users" do
        get :index, params: { page: 2 }
        users = assigns(:users)
        pagy = assigns(:pagy)
        expect(pagy.page).to eq(2)
        expect(users.count).to eq(9)
        expect(users.map(&:id)).to eq(User.offset(9).limit(9).pluck(:id))
        expect(response).to have_http_status(:ok)
      end

      it "displays the third page of users with 2 users" do
        get :index, params: { page: 3 }
        users = assigns(:users)
        pagy = assigns(:pagy)
        expect(pagy.page).to eq(3)
        expect(users.count).to eq(2)
        expect(response).to have_http_status(:ok)
      end

      it "includes professions in the results for eager loading" do
        get :index
        users = assigns(:users)
        expect(users).to all(be_an_instance_of(User))
        expect(users.first.professions).to be_loaded # Eager loading check
        expect(response).to have_http_status(:ok)
      end

      it "assigns the correct search URL" do
        get :index
        search_url = assigns(:search_url)
        expect(search_url).to eq(users_path)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user performs a search" do
      it "returns the correct search results based on profession" do
        get :index, params: { q: { profession_cont: "Developer" } }
        users = assigns(:users)
        expect(users).to all(have_attributes(profession: "Developer"))
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct search results based on location" do
        get :index, params: { q: { pin_code_eq: "123456" } }
        users = assigns(:users)
        expect(users).to all(have_attributes(pin_code: "123456"))
        expect(response).to have_http_status(:ok)
      end

      it "does not return any users if the search does not match" do
        get :index, params: { q: { full_name_cont: "NonExistentName" } }
        users = assigns(:users)
        expect(users.count).to eq(0)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested user" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(response).to have_http_status(:ok)
    end

    it "calculates the average rating for the user" do
      allow(User).to receive(:average_rating).with(user.id).and_return(4.5)
      get :show, params: { id: user.id }
      expect(assigns(:average_rating)).to eq(4.5)
      expect(response).to have_http_status(:ok)
    end

    it "renders the show template" do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
    end

    it "returns a 404 if the user is not found" do
      expect {
        get :show, params: { id: 999 }
      }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to have_http_status(:ok)
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
