class AddClubToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :club, :boolean
  end
end
