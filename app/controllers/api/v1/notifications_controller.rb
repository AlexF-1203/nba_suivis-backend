# app/controllers/api/v1/notifications_controller.rb
class Api::V1::NotificationsController < Api::V1::ApplicationController
  skip_before_action :authenticate_token!, only: [:test]

  def test
    begin
      device_tokens = current_user.device_tokens.where(active: true)

      if device_tokens.empty?
        render json: { error: 'No active device tokens found' }, status: :not_found
        returnn
      end

      game = Game.last
      if game
        NotificationService.notify_game_finished(game)
        render json: { message: 'Test notification sent successfully' }
      else
        render json: { error: 'No games found for testing' }, status: :not_found
      end
    rescue => e
      Rails.logger.error "Error in test notification: #{e.message}"
      render json: { error: e.message }, status: :internal_server_error
    end
  end

end
