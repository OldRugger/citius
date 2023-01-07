class AddIsTeamEligibleToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :is_team_eligible, :boolean
  end
end
