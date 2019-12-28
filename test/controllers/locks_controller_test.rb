require 'test_helper'

class LocksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get locks_index_url
    assert_response :success
  end

end
