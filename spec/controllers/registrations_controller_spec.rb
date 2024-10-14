require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          user = create(:user, email: 'dhamodoe@example.com', password: 'password123')
          post :create, params: { user: { email: user.email, password: 'password123' } }
          user = assigns(:user)
          if user.errors.any?
            puts "Validation Errors: #{user.errors.full_messages.join(', ')}"
          end
        }.to change(User, :count).by(1)
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq('User was successfully created.')
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
    end
  end
end
