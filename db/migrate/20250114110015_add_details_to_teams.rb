class AddDetailsToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :city, :string
    add_column :teams, :logo_url, :string
  end
end
