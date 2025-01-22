# app/services/notification_service.rb
require 'net/http'
require 'uri'

class NotificationService
  EXPO_API_URL = "https://exp.host/--/api/v2/push/send"

  def self.notify_game_finished(game)
    message = {
      title: "Match terminé !",
      body: "#{game.team_1.name} #{game.team_1_score} - #{game.team_2_score} #{game.team_2.name}",
      data: { game_id: game.id.to_s, type: 'game_finished' }
    }

    DeviceToken.where(active: true).find_each do |device_token|
      begin
        response = send_push_notification(device_token.token, message)
        Rails.logger.info "Notification sent to #{device_token.token}: #{response.body}"
      rescue => e
        Rails.logger.error "Failed to send notification to #{device_token.token}: #{e.message}"
      end
    end
  end

  private

  def self.send_push_notification(token, message)
    uri = URI.parse(EXPO_API_URL)
    request = Net::HTTP::Post.new(uri.path,
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    )
    request.body = { to: token, sound: 'default', title: message[:title], body: message[:body], data: message[:data] }.to_json

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

end
