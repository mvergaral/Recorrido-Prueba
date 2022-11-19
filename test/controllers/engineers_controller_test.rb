require "test_helper"

class EngineersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @engineer = engineers(:one)
  end

  test "should get index" do
    get engineers_url
    assert_response :success
  end

  test "should get new" do
    get new_engineer_url
    assert_response :success
  end

  test "should create engineer" do
    assert_difference("Engineer.count") do
      post engineers_url, params: { engineer: { color: @engineer.color, name: @engineer.name } }
    end

    assert_redirected_to engineer_url(Engineer.last)
  end

  test "should show engineer" do
    get engineer_url(@engineer)
    assert_response :success
  end

  test "should get edit" do
    get edit_engineer_url(@engineer)
    assert_response :success
  end

  test "should update engineer" do
    patch engineer_url(@engineer), params: { engineer: { color: @engineer.color, name: @engineer.name } }
    assert_redirected_to engineer_url(@engineer)
  end

  test "should destroy engineer" do
    assert_difference("Engineer.count", -1) do
      delete engineer_url(@engineer)
    end

    assert_redirected_to engineers_url
  end
end
