class AddNameToConfigs < ActiveRecord::Migration[7.0]
  def change
    add_column :configs, :name, :string
  end
end
