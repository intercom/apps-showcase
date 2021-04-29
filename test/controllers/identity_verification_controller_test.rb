require "test_helper"

class IdentityVerificationControllerTest < ActionDispatch::IntegrationTest
  test "should get initialize_url" do
    get identity_verification_initialize_url_url
    assert_response :success
  end

  test "should get submit_url" do
    get identity_verification_submit_url_url
    assert_response :success
  end
end
