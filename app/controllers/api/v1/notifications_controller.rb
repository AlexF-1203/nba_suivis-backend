class Api::V1::NotificationsController < Api::V1::ApplicationController
  def test
    # Utilisons les tokens existants au lieu d'en créer un nouveau
    device_tokens = current_user.device_tokens.where(active: true)

    if device_tokens.empty?
      render json: { error: 'No active device tokens found' }, status: :not_found
      return
    end

    game = Game.last
    if game
      NotificationService.notify_game_finished(game)
      render json: { message: 'Test notification sent successfully' }
    else
      render json: { error: 'No games found for testing' }, status: :not_found
    end
  end
end
