require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get home_view_url
    assert_response :success
  end
end
