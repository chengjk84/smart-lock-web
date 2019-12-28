require 'test_helper'

class PasscodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get passcodes_index_url
    assert_response :success
  end

end
