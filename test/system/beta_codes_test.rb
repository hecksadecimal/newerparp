require "application_system_test_case"

class BetaCodesTest < ApplicationSystemTestCase
  setup do
    @beta_code = beta_codes(:one)
  end

  test "visiting the index" do
    visit beta_codes_url
    assert_selector "h1", text: "Beta codes"
  end

  test "should create beta code" do
    visit beta_codes_url
    click_on "New beta code"

    fill_in "Account", with: @beta_code.account_id
    fill_in "Code", with: @beta_code.code
    click_on "Create Beta code"

    assert_text "Beta code was successfully created"
    click_on "Back"
  end

  test "should update Beta code" do
    visit beta_code_url(@beta_code)
    click_on "Edit this beta code", match: :first

    fill_in "Account", with: @beta_code.account_id
    fill_in "Code", with: @beta_code.code
    click_on "Update Beta code"

    assert_text "Beta code was successfully updated"
    click_on "Back"
  end

  test "should destroy Beta code" do
    visit beta_code_url(@beta_code)
    click_on "Destroy this beta code", match: :first

    assert_text "Beta code was successfully destroyed"
  end
end
