require "test_helper"

class RfpsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rfps_index_url
    assert_response :success
  end

  test "should get show" do
    get rfps_show_url
    assert_response :success
  end

  test "should get new" do
    get rfps_new_url
    assert_response :success
  end

  test "should get create" do
    get rfps_create_url
    assert_response :success
  end

  test "should get edit" do
    get rfps_edit_url
    assert_response :success
  end

  test "should get update" do
    get rfps_update_url
    assert_response :success
  end
end
