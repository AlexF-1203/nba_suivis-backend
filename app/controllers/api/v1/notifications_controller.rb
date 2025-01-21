class Api::V1::NotificationsController < Api::V1::ApplicationController
  def test
    game = Game.last # ou un jeu spécifique
    NotificationService.notify_game_finished(game)
    render json: { message: 'Test notification sent' }
  end
end
