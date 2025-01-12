class CreateFavoriteTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :favorite_teams do |t|
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
