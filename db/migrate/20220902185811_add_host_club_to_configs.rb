class AddHostClubToConfigs < ActiveRecord::Migration[7.0]
  def change
    add_column :configs, :host_club, :string
  end
end
