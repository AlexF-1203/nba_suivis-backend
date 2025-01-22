require 'net/http'
require 'uri'
require 'json'

class NotificationService
  EXPO_PUSH_ENDPOINT = 'https://exp.host/--/api/v2/push/send'

  class << self
    def notify_game_finished(game)
      return unless game.status == "Finished"

      title = "Match terminé"
      body = "#{game.team_1.name} #{game.team_1_score} - #{game.team_2_score} #{game.team_2.name}"

      User.joins(:device_tokens)
          .where(device_tokens: { active: true })
          .find_each do |user|
        user.device_tokens.each do |token|
          send_expo_notification(token.token, title, body)
        end
      end
    end

    def send_test_notification(tokens, user)
      title = "Test Notification"
      body = "Bonjour #{user.username}! Ceci est une notification de test."
      data = { type: 'test' }

      tokens.each do |token|
        send_expo_notification(token, title, body)
      end
    end

    private

    def send_expo_notification(token, title, body)
      uri = URI.parse(EXPO_PUSH_ENDPOINT)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path)
      request['Accept'] = 'application/json'
      request['Content-Type'] = 'application/json'

      request.body = {
        to: token,
        title: title,
        body: body,
        sound: 'default'
      }.to_json

      response = http.request(request)
      Rails.logger.info "Notification response: #{response.body}"
    rescue => e
      Rails.logger.error "Failed to send notification: #{e.message}"
    end
  end
end
