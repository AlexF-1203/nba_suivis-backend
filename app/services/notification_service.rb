# app/services/notification_service.rb
require 'net/http'
require 'uri'

class NotificationService
  class << self
    def notify_game_finished(game)
      return unless game.status == "Finished"

      title = "Match terminé"
      body = "#{game.team_1.name} #{game.team_1_score} - #{game.team_2_score} #{game.team_2.name}"

      User.joins(:device_tokens)
          .where(device_tokens: { active: true })
          .find_each do |user|
        user.device_tokens.each do |token|
          send_firebase_notification(token.token, title, body)
        end
      end
    end

    def send_test_notification(tokens, user)
      tokens.each do |token|
        send_push_notification(
          token,
          {
            title: "Test Notification",
            body: "Bonjour #{user.username}! Ceci est une notification de test.",
            data: { type: 'test' }
          }
        )
      end
    end

    private

    def send_push_notification(token, message)
      response = HTTP.post(
        'https://exp.host/--/api/v2/push/send',
        json: {
          to: token,
          title: message[:title],
          body: message[:body],
          data: message[:data],
          sound: 'default'
        },
        headers: { 'Accept' => 'application/json' }
      )

      unless response.status.success?
        Rails.logger.error "Push notification error: #{response.body}"
        raise "Failed to send push notification: #{response.status}"
      end

      Rails.logger.info "Push notification sent: #{response.body}"
    end
  end

  def send_firebase_notification(token, title, body)
    message = {
      notification: {
        title: title,
        body: body
      },
      token: token
    }

    begin
      response = $firebase_messaging.send(message)
      Rails.logger.info "Successfully sent notification: #{response}"
    rescue => e
      Rails.logger.error "Error sending notification: #{e.message}"
    end
  end
end
end
