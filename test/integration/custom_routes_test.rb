require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
  test "that /login route opens the login page" do
  	get "/login"
  	assert_response :success
  end

  test "that /register route opens the register page" do
  	get "/register"
  	assert_response :success
  end

  test "that a profile page works" do
  	get '/danielbisgrove'
  	assert_response :success
  end

end
