require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(root_path)
      end

      it 'sets a success flash message' do
        post :create, params: { user: attributes_for(:user) }
        expect(flash[:notice]).to eq('User was successfully created.')
      end

      it 'returns HTTP status 302 (redirect)' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: attributes_for(:user, email: nil) }
        }.to_not change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: attributes_for(:user, email: nil) }
        expect(response).to render_template(:new)
      end

      it 'sets an error flash message' do
        post :create, params: { user: attributes_for(:user, email: nil) }
        expect(flash[:alert]).to eq('There was a problem creating the user.')
      end
    end
  end
end
