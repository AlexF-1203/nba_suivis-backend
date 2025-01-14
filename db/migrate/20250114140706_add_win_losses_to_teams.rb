class AddWinLossesToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :wins, :integer
    add_column :teams, :losses, :integer
  end
end
