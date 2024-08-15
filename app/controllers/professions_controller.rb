class ProfessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]
  def search
    @professions = Profession.search_by_name(params[:q])
    respond_to do |format|
      format.json { render json: @professions }
    end
  end
end
