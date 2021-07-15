require "test_helper"

class Api::V1::FoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_foods_index_url
    assert_response :success
  end
end
