# app/services/notification_service.rb
require 'net/http'
require 'uri'

class NotificationService
  EXPO_API_URL = "https://exp.host/--/api/v2/push/send"

  def self.notify_game_finished(game)
    message = {
      title: "Match terminé !",
      body: "#{game.team_1.name} #{game.team_1_score} - #{game.team_2_score} #{game.team_2.name}",
      data: {
        game_id: game.id.to_s,
        type: 'game_finished',
        team_1: game.team_1.name,
        team_2: game.team_2.name,
        score_1: game.team_1_score.to_s,
        score_2: game.team_2_score.to_s
      }
    }

    DeviceToken.where(active: true).find_each do |device_token|
      begin
        notification = {
          to: device_token.token,
          sound: 'default',
          title: message[:title],
          body: message[:body],
          data: message[:data]
        }

        uri = URI.parse(EXPO_API_URL)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(uri.path,
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        )
        request.body = notification.to_json

        response = http.request(request)

        if !response.is_a?(Net::HTTPSuccess)
          Rails.logger.error "Failed to send notification: #{response.body}"
          device_token.update(active: false) if response.body.include?('DeviceNotRegistered')
        end
      rescue => e
        Rails.logger.error "Error sending notification: #{e.message}"
      end
    end
  end
end
