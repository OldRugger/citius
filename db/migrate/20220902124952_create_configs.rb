class CreateConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :configs do |t|
      t.boolean :active_config
      t.string :title
      t.string :hotfolder
      t.integer :max_time
      t.integer :day
      t.boolean :load_teams
      t.string :csv_delimiter
      t.string :unique_id
      t.string :firstname
      t.string :lastname
      t.string :entry_class
      t.string :gender
      t.string :classifier
      t.string :time
      t.string :school
      t.string :team
      t.string :jrotc
      t.string :other_class
      t.string :other_class_title

      t.timestamps
    end
  end
end
