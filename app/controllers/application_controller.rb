class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

end
