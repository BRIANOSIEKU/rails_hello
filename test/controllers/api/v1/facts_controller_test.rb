require "test_helper"

class Api::V1::FactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fact = Fact.create!(title: "Test Fact", content: "This is a test fact.")
  end

  test "should get index" do
    get api_v1_facts_url
    assert_response :success
  end

  test "should create fact" do
    assert_difference("Fact.count") do
      post api_v1_facts_url, params: { fact: { title: "New Fact", content: "New content" } }, as: :json
    end
    assert_response :created
  end

  test "should show fact" do
    get api_v1_fact_url(@fact)
    assert_response :success
  end

  test "should update fact" do
    patch api_v1_fact_url(@fact), params: { fact: { content: "Updated content" } }, as: :json
    assert_response :success
  end

  test "should destroy fact" do
    assert_difference("Fact.count", -1) do
      delete api_v1_fact_url(@fact)
    end
    assert_response :no_content
  end
end
