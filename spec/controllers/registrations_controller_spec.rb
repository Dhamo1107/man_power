require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        profession = create(:profession)
        expect {
          post :create, params: {
            user: {
              full_name: "test", user_name: "_test_", phone_number: "9999999999", email: "cccc@gmail.com", password: "password123", password_confirmation: "password123",
              date_of_birth: "2005-10-22", experience_years: 1, district: "Salem", pin_code: "638145", address: "salem", profession_ids: [profession.id]
            }
          }
        }.to change(User, :count).by(1)
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Welcome! You have signed up successfully.')
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
