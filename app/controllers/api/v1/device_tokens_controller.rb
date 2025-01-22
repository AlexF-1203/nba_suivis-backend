class Api::V1::DeviceTokensController < Api::V1::ApplicationController
  def create
    Rails.logger.info "Creating device token with params: #{params.inspect}"

    begin
      @device_token = current_user.device_tokens.create!(
        token: device_token_params[:token],
        platform: device_token_params[:platform],
        active: true
      )

      Rails.logger.info "Created device token: #{@device_token.inspect}"

      render json: {
        message: 'Device token registered successfully',
        device_token: @device_token
      }, status: :created
    rescue => e
      Rails.logger.error "Failed to create device token: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def status
    tokens = current_user.device_tokens.where(active: true)
    render json: {
      hasActiveToken: tokens.exists?,
      activeTokenCount: tokens.count
    }
  end

  def test
    tokens = current_user.device_tokens.where(active: true)
    Rails.logger.info "Found #{tokens.count} active tokens: #{tokens.map(&:token)}"

    if tokens.empty?
      return render json: { error: 'No active device tokens found' }, status: :not_found
    end

    begin
      tokens.each do |device_token|
        NotificationService.send_test_notification([device_token.token], current_user)
      end
      render json: { message: 'Test notification sent' }
    rescue => e
      Rails.logger.error "Failed to send test notification: #{e.message}"
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  private

  def device_token_params
    params.require(:device_token).permit(:token, :platform, :active)
  end
end
