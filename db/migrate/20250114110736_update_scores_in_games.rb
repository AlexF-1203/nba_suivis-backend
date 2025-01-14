class UpdateScoresInGames < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :score, :integer
    add_column :games, :team_1_score, :integer
    add_column :games, :team_2_score, :integer
  end
end
