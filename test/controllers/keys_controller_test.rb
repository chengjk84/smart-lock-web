require 'test_helper'

class KeysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get keys_index_url
    assert_response :success
  end

end
