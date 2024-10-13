require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "User Log in" do
    context "with empty credentials" do
      it "returns unprocessable_entity when both email and password are empty" do
        post :create, params: { user: { email: '', password: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq("Invalid Email or password.")
      end
    end

    context "with invalid credentials" do
      it "returns unprocessable_entity when email or password is incorrect" do
        post :create, params: { user: { email: 'invalid@example.com', password: 'password123' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq("Invalid Email or password.")
      end
    end

    context "with valid credentials" do
      it "logs in successfully with correct email and password" do
        user = create(:user, email: 'john.doe@example.com', password: 'password123')
        post :create, params: { user: { email: user.email, password: 'password123' } }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context "when already logged in" do
      it "redirects the user to the home page" do
        user = create(:user)
        sign_in user
        get :new
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You are already signed in.")
        expect(response).to have_http_status(:found)
      end
    end

    context "when logging out" do
      it "redirects the user to the login page" do
        user = create(:user)
        sign_in user

        # Simulate logging out
        delete :destroy, params: { id: user.id }

        # Check the redirection to the login page
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:notice]).to eq("Signed out successfully.")
        expect(response).to have_http_status(:see_other)
      end
    end
  end
end
