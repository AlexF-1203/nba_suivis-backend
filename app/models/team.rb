class Team < ApplicationRecord
  has_many :players
  has_many :games

  has_many :home_games, class_name: 'Game', foreign_key: 'team_1_id'
  has_many :away_games, class_name: 'Game', foreign_key: 'team_2_id'

  def games
    Game.where('team_1_id = ? OR team_2_id = ?', id, id)
  end
end
