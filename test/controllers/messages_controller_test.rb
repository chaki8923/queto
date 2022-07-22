require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get craete" do
    get messages_craete_url
    assert_response :success
  end
end
