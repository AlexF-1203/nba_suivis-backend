class PlayerGame < ApplicationRecord
  belongs_to :player
  belongs_to :game
  belongs_to :team

  validates :player_id, uniqueness: { scope: :game_id }
  validates :points, :rebounds, :assists, :minutes,
            :offensive_rebounds, :defensive_rebounds,
            :blocks, :steals, :personal_fouls, :turnovers,
            presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :free_throw_percentage, :three_point_percentage, :true_shooting_percentage,
            presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
