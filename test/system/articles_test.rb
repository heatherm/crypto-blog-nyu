require "application_system_test_case"

class ArticlesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "viewing the index" do
    sign_in users(:alice)

    get '/articles'

    assert_response :success

    sign_out users(:alice)

    assert_response :success
  end
end
