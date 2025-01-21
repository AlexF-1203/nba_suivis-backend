class NotificationService
  def self.notify_game_finished(game)
    title = "Match terminé !"
    body = "#{game.team_1.name} #{game.team_1_score} - #{game.team_2_score} #{game.team_2.name}"

    data = {
      game_id: game.id.to_s,
      type: 'game_finished',
      team_1: game.team_1.name,
      team_2: game.team_2.name,
      score_1: game.team_1_score.to_s,
      score_2: game.team_2_score.to_s
    }

    DeviceToken.where(active: true).find_each do |device_token|
      begin
        message = {
          notification: {
            title: title,
            body: body
          },
          data: data,
          token: device_token.token
        }

        response = FirebaseAdmin::Messaging.send_message(message)
        Rails.logger.info "Notification sent successfully: #{response}"
      rescue => e
        Rails.logger.debug "Sending notification to token: #{device_token.token}"
        Rails.logger.debug "Message content: #{message.inspect}"
        Rails.logger.error "Error sending notification: #{e.message}"
        device_token.update(active: false) if e.message.include?('unregistered')
      end
    end
  end
end
