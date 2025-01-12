class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :team_1, null: false, foreign_key: { to_table: :teams }
      t.references :team_2, null: false, foreign_key: { to_table: :teams }
      t.datetime :date
      t.integer :score

      t.timestamps
    end
  end
end
