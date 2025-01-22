require 'net/http'
require 'uri'
require 'json'

class ExpoNotificationService
  EXPO_PUSH_API = 'https://exp.host/--/api/v2/push/send'.freeze

  def self.send_notification(tokens, title, body, data = {})
    messages = tokens.map do |token|
      {
        to: token,
        sound: 'default',
        title: title,
        body: body,
        data: data
      }
    end

    uri = URI.parse(EXPO_PUSH_API)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Accept'] = 'application/json'
    request['Accept-encoding'] = 'gzip, deflate'
    request['Content-Type'] = 'application/json'

    request.body = messages.to_json

    response = http.request(request)

    if response.code == '200'
      Rails.logger.info "Notifications sent successfully"
    else
      Rails.logger.error "Error sending notifications: #{response.body}"
    end

    JSON.parse(response.body)
  end
end
