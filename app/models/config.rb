class Config < ApplicationRecord
  DEFAULT_VALUES = {
    active_config: false,
    title: 'Southeast Interscholastic Championships',
    hotfolder: 'results',
    max_time: 180,
    day: 1,
    load_teams: true,
    csv_delimiter: ';',
    unique_id: 'Stno',
    firstname: 'First name',
    lastname: 'Surname',
    entry_class: 'Short',
    gender: 'S',
    classifier: 'Classifier',
    time: 'Time',
    school: 'Text2',
    team: 'Text3',
    jrotc: 'Text1',
    other_class: nil,
    other_class_title: nil,
  }

  def self.create_default_config
    config = Config.create(Config::DEFAULT_VALUES)
    config.update(active_config: true) if Config.count == 1
    config.save 
    config 
  end  
end
