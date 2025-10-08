require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(username: "testuser", password: "secret123")
  end

  test "should get index" do
    get api_v1_users_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post api_v1_users_url, params: { user: { username: "newuser", password: "password123" } }, as: :json
    end
    assert_response :created
  end

  test "should show user" do
    get api_v1_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch api_v1_user_url(@user), params: { user: { username: "updateduser", password: "secret123" } }, as: :json
    assert_response :success
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete api_v1_user_url(@user)
    end
    assert_response :no_content
  end
end
