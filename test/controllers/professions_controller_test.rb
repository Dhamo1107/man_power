require "test_helper"

class ProfessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get professions_search_url
    assert_response :success
  end
end
