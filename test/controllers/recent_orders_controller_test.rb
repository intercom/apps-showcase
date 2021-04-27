require "test_helper"

class RecentOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get initialize" do
    get recent_orders_initialize_url
    assert_response :success
  end
end
