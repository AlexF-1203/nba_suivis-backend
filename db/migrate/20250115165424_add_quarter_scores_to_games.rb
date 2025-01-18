class AddQuarterScoresToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :team_1_q1, :integer
    add_column :games, :team_1_q2, :integer
    add_column :games, :team_1_q3, :integer
    add_column :games, :team_1_q4, :integer
    add_column :games, :team_2_q1, :integer
    add_column :games, :team_2_q2, :integer
    add_column :games, :team_2_q3, :integer
    add_column :games, :team_2_q4, :integer
    add_column :games, :status, :string
  end
end
