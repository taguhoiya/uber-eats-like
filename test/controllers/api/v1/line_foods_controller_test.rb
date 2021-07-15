require "test_helper"

class Api::V1::LineFoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_line_foods_index_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_line_foods_create_url
    assert_response :success
  end

  test "should get replace" do
    get api_v1_line_foods_replace_url
    assert_response :success
  end
end
