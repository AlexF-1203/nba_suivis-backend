class CreatePlayerGames < ActiveRecord::Migration[7.1]
  def change
    create_table :player_games do |t|
      t.references :player, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      # Stats basiques
      t.integer :points
      t.integer :rebounds
      t.integer :assists  # PD (passes décisives)
      t.integer :minutes

      # Stats avancées
      t.integer :blocks             # BLK
      t.integer :steals             # STL
      t.decimal :free_throw_percentage  # FT%
      t.decimal :true_shooting_percentage  # TS%

      t.timestamps
    end

    # Index pour assurer l'unicité d'un joueur par match
    add_index :player_games, [:player_id, :game_id], unique: true
  end
end
