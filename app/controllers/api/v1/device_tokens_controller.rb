# app/controllers/api/v1/device_tokens_controller.rb
class Api::V1::DeviceTokensController < Api::V1::ApplicationController
  rescue_from StandardError, with: :handle_error

  def create
    ActiveRecord::Base.transaction do
      current_user.device_tokens.update_all(active: false)
      @device_token = current_user.device_tokens.find_or_initialize_by(token: token_params[:token])
      @device_token.update!(
        platform: token_params[:platform],
        active: true
      )
    end

    render json: {
      message: 'Device token registered successfully',
      device_token: @device_token
    }, status: :created
  end

  private

  def token_params
    params.require(:device_token).permit(:token, :platform)
  end

  def handle_error(error)
    Rails.logger.error "DeviceTokens Error: #{error.message}"
    Rails.logger.error error.backtrace.join("\n")
    render json: { error: error.message }, status: :internal_server_error
  end
end

# app/models/game.rb
class Game < ApplicationRecord
  after_commit :notify_if_status_changed

  private

  def notify_if_status_changed
    return unless saved_change_to_status? && status == "Finished"

    NotificationService.notify_game_finished(self)
  end
end

# app/services/notification_service.rb
class NotificationService
  class << self
    def notify_game_finished(game)
      title = "Match terminé"
      body = "#{game.team_1.name} #{game.team_1_score} - #{game.team_2_score} #{game.team_2.name}"
      data = {
        type: 'game_finished',
        game_id: game.id,
        team_1: game.team_1.as_json(only: [:id, :name]),
        team_2: game.team_2.as_json(only: [:id, :name]),
        score: {
          team_1: game.team_1_score,
          team_2: game.team_2_score
        }
      }

      send_notification_to_users(title, body, data)
    end

    private

    def send_notification_to_users(title, body, data = {})
      DeviceToken.where(active: true).find_each do |token|
        send_expo_notification(token.token, title, body, data)
      end
    end

    def send_expo_notification(token, title, body, data = {})
      uri = URI.parse('https://exp.host/--/api/v2/push/send')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path)
      request['Accept'] = 'application/json'
      request['Content-Type'] = 'application/json'

      request.body = {
        to: token,
        title: title,
        body: body,
        data: data,
        sound: 'default',
        priority: 'high'
      }.to_json

      response = http.request(request)

      handle_notification_response(response, token)
    rescue => e
      Rails.logger.error "Failed to send notification to #{token}: #{e.message}"
    end

    def handle_notification_response(response, token)
      return if response.code == '200'

      Rails.logger.error "Notification error for token #{token}: #{response.body}"

      if JSON.parse(response.body)['details']&.include?('DeviceNotRegistered')
        DeviceToken.find_by(token: token)&.update(active: false)
      end
    end
  end
end
