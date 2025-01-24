class Game < ApplicationRecord
  belongs_to :team_1, class_name: 'Team'
  belongs_to :team_2, class_name: 'Team'
  has_many :player_games, dependent: :destroy
  has_many :players, through: :player_games

  after_save :notify_if_finished

  private

  def notify_if_finished
    if saved_change_to_attribute?(:status) && status == "Finished"
      Rails.logger.info "Game #{id} finished, sending notification..."
      NotificationService.notify_game_finished(self)
    end
  end
end
