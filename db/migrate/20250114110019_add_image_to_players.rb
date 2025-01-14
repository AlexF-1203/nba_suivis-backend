class AddImageToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :image, :string
  end
end
