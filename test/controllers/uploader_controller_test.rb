require "test_helper"

class UploaderControllerTest < ActionDispatch::IntegrationTest
  test "should get image" do
    get uploader_image_url
    assert_response :success
  end
end
