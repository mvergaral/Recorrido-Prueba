require "application_system_test_case"

class TurnAvailabilitiesTest < ApplicationSystemTestCase
  setup do
    @turn_availability = turn_availabilities(:one)
  end

  test "visiting the index" do
    visit turn_availabilities_url
    assert_selector "h1", text: "Turn availabilities"
  end

  test "should create turn availability" do
    visit turn_availabilities_url
    click_on "New turn availability"

    fill_in "Company", with: @turn_availability.company_id
    fill_in "Date", with: @turn_availability.date
    fill_in "Engineer", with: @turn_availability.engineer_id
    fill_in "Turn", with: @turn_availability.turn_id
    click_on "Create Turn availability"

    assert_text "Turn availability was successfully created"
    click_on "Back"
  end

  test "should update Turn availability" do
    visit turn_availability_url(@turn_availability)
    click_on "Edit this turn availability", match: :first

    fill_in "Company", with: @turn_availability.company_id
    fill_in "Date", with: @turn_availability.date
    fill_in "Engineer", with: @turn_availability.engineer_id
    fill_in "Turn", with: @turn_availability.turn_id
    click_on "Update Turn availability"

    assert_text "Turn availability was successfully updated"
    click_on "Back"
  end

  test "should destroy Turn availability" do
    visit turn_availability_url(@turn_availability)
    click_on "Destroy this turn availability", match: :first

    assert_text "Turn availability was successfully destroyed"
  end
end
