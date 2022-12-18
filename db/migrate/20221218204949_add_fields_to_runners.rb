class AddFieldsToRunners < ActiveRecord::Migration[7.0]
  def change
    add_column :runners, :jrotc, :string
    add_column :runners, :is_individual_eligible, :boolean
  end
end
