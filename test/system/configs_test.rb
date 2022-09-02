require "application_system_test_case"

class ConfigsTest < ApplicationSystemTestCase
  setup do
    @config = configs(:one)
  end

  test "visiting the index" do
    visit configs_url
    assert_selector "h1", text: "Configs"
  end

  test "should create config" do
    visit configs_url
    click_on "New config"

    check "Active config" if @config.active_config
    fill_in "Classifier", with: @config.classifier
    fill_in "Csv delimiter", with: @config.csv_delimiter
    fill_in "Day", with: @config.day
    fill_in "Entry class", with: @config.entry_class
    fill_in "Firstname", with: @config.firstname
    fill_in "Gender", with: @config.gender
    fill_in "Hotfolder", with: @config.hotfolder
    fill_in "Jrotc", with: @config.jrotc
    fill_in "Lastname", with: @config.lastname
    check "Load teams" if @config.load_teams
    fill_in "Max time", with: @config.max_time
    fill_in "Other class", with: @config.other_class
    fill_in "Other class title", with: @config.other_class_title
    fill_in "School", with: @config.school
    fill_in "Team", with: @config.team
    fill_in "Time", with: @config.time
    fill_in "Title", with: @config.title
    fill_in "Unique", with: @config.unique_id
    click_on "Create Config"

    assert_text "Config was successfully created"
    click_on "Back"
  end

  test "should update Config" do
    visit config_url(@config)
    click_on "Edit this config", match: :first

    check "Active config" if @config.active_config
    fill_in "Classifier", with: @config.classifier
    fill_in "Csv delimiter", with: @config.csv_delimiter
    fill_in "Day", with: @config.day
    fill_in "Entry class", with: @config.entry_class
    fill_in "Firstname", with: @config.firstname
    fill_in "Gender", with: @config.gender
    fill_in "Hotfolder", with: @config.hotfolder
    fill_in "Jrotc", with: @config.jrotc
    fill_in "Lastname", with: @config.lastname
    check "Load teams" if @config.load_teams
    fill_in "Max time", with: @config.max_time
    fill_in "Other class", with: @config.other_class
    fill_in "Other class title", with: @config.other_class_title
    fill_in "School", with: @config.school
    fill_in "Team", with: @config.team
    fill_in "Time", with: @config.time
    fill_in "Title", with: @config.title
    fill_in "Unique", with: @config.unique_id
    click_on "Update Config"

    assert_text "Config was successfully updated"
    click_on "Back"
  end

  test "should destroy Config" do
    visit config_url(@config)
    click_on "Destroy this config", match: :first

    assert_text "Config was successfully destroyed"
  end
end
