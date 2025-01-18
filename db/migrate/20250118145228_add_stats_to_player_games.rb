class AddStatsToPlayerGames < ActiveRecord::Migration[7.1]
  def change
    add_column :player_games, :three_point_percentage, :decimal
    add_column :player_games, :personal_fouls, :integer
    add_column :player_games, :turnovers, :integer
    add_column :player_games, :offensive_rebounds, :integer
    add_column :player_games, :defensive_rebounds, :integer
  end
end
