class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :conference
      t.integer :rank

      t.timestamps
    end
  end
end
