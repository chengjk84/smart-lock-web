require 'test_helper'

class RfidsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rfids_index_url
    assert_response :success
  end

end
