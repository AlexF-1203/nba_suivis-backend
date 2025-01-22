class Api::V1::NotificationsController < Api::V1::ApplicationController
  def test
    @device_token = current_user.device_tokens.create!(
      token: "test_expo_token_#{Time.current.to_i}",
      platform: "ios",
      active: true
    )

    game = Game.last
    if game
      NotificationService.notify_game_finished(game)
      render json: { message: 'Test notification sent successfully' }
    else
      render json: { error: 'No games found for testing' }, status: :not_found
    end
  end
end
