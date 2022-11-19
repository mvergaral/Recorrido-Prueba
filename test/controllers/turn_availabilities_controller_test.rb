require "test_helper"

class TurnAvailabilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @turn_availability = turn_availabilities(:one)
  end

  test "should get index" do
    get turn_availabilities_url
    assert_response :success
  end

  test "should get new" do
    get new_turn_availability_url
    assert_response :success
  end

  test "should create turn_availability" do
    assert_difference("TurnAvailability.count") do
      post turn_availabilities_url, params: { turn_availability: { company_id: @turn_availability.company_id, date: @turn_availability.date, engineer_id: @turn_availability.engineer_id, turn_id: @turn_availability.turn_id } }
    end

    assert_redirected_to turn_availability_url(TurnAvailability.last)
  end

  test "should show turn_availability" do
    get turn_availability_url(@turn_availability)
    assert_response :success
  end

  test "should get edit" do
    get edit_turn_availability_url(@turn_availability)
    assert_response :success
  end

  test "should update turn_availability" do
    patch turn_availability_url(@turn_availability), params: { turn_availability: { company_id: @turn_availability.company_id, date: @turn_availability.date, engineer_id: @turn_availability.engineer_id, turn_id: @turn_availability.turn_id } }
    assert_redirected_to turn_availability_url(@turn_availability)
  end

  test "should destroy turn_availability" do
    assert_difference("TurnAvailability.count", -1) do
      delete turn_availability_url(@turn_availability)
    end

    assert_redirected_to turn_availabilities_url
  end
end
