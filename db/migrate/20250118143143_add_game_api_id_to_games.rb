class AddGameApiIdToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :game_api_id, :integer
    add_index :games, :game_api_id
  end
end
