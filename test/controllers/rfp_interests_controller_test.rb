require "test_helper"

class RfpInterestsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get rfp_interests_create_url
    assert_response :success
  end

  test "should get destroy" do
    get rfp_interests_destroy_url
    assert_response :success
  end
end
