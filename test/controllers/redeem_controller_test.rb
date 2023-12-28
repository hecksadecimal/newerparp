require "test_helper"

class RedeemControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get redeem_show_url
    assert_response :success
  end

  test "should get consume" do
    get redeem_consume_url
    assert_response :success
  end
end
