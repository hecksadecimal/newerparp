require "test_helper"

class BetaCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beta_code = beta_codes(:one)
  end

  test "should get index" do
    get beta_codes_url
    assert_response :success
  end

  test "should get new" do
    get new_beta_code_url
    assert_response :success
  end

  test "should create beta_code" do
    assert_difference("BetaCode.count") do
      post beta_codes_url, params: { beta_code: { account_id: @beta_code.account_id, code: @beta_code.code } }
    end

    assert_redirected_to beta_code_url(BetaCode.last)
  end

  test "should show beta_code" do
    get beta_code_url(@beta_code)
    assert_response :success
  end

  test "should get edit" do
    get edit_beta_code_url(@beta_code)
    assert_response :success
  end

  test "should update beta_code" do
    patch beta_code_url(@beta_code), params: { beta_code: { account_id: @beta_code.account_id, code: @beta_code.code } }
    assert_redirected_to beta_code_url(@beta_code)
  end

  test "should destroy beta_code" do
    assert_difference("BetaCode.count", -1) do
      delete beta_code_url(@beta_code)
    end

    assert_redirected_to beta_codes_url
  end
end
