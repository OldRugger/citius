require "test_helper"

class ConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @config = configs(:one)
  end

  test "should get index" do
    get configs_url
    assert_response :success
  end

  test "should get new" do
    get new_config_url
    assert_response :success
  end

  test "should create config" do
    assert_difference("Config.count") do
      post configs_url, params: { config: { active_config: @config.active_config, classifier: @config.classifier, csv_delimiter: @config.csv_delimiter, day: @config.day, entry_class: @config.entry_class, firstname: @config.firstname, gender: @config.gender, hotfolder: @config.hotfolder, jrotc: @config.jrotc, lastname: @config.lastname, load_teams: @config.load_teams, max_time: @config.max_time, other_class: @config.other_class, other_class_title: @config.other_class_title, school: @config.school, team: @config.team, time: @config.time, title: @config.title, unique_id: @config.unique_id } }
    end

    assert_redirected_to config_url(Config.last)
  end

  test "should show config" do
    get config_url(@config)
    assert_response :success
  end

  test "should get edit" do
    get edit_config_url(@config)
    assert_response :success
  end

  test "should update config" do
    patch config_url(@config), params: { config: { active_config: @config.active_config, classifier: @config.classifier, csv_delimiter: @config.csv_delimiter, day: @config.day, entry_class: @config.entry_class, firstname: @config.firstname, gender: @config.gender, hotfolder: @config.hotfolder, jrotc: @config.jrotc, lastname: @config.lastname, load_teams: @config.load_teams, max_time: @config.max_time, other_class: @config.other_class, other_class_title: @config.other_class_title, school: @config.school, team: @config.team, time: @config.time, title: @config.title, unique_id: @config.unique_id } }
    assert_redirected_to config_url(@config)
  end

  test "should destroy config" do
    assert_difference("Config.count", -1) do
      delete config_url(@config)
    end

    assert_redirected_to configs_url
  end
end
