class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :full_name, :user_name, :phone_number, :date_of_birth,
      { profession_ids: [] }, :experience_years, :address, :district,
      :pin_code, :bio
    ])

    devise_parameter_sanitizer.permit(:account_update, keys: [
      :full_name, :user_name, :phone_number, :date_of_birth,
      { profession_ids: [] }, :experience_years, :address, :district,
      :pin_code, :bio
    ])
  end

end
