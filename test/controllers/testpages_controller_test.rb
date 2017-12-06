require 'test_helper'

class TestpagesControllerTest < ActionDispatch::IntegrationTest
  test "should get finish" do
    get testpages_finish_url
    assert_response :success
  end

end
