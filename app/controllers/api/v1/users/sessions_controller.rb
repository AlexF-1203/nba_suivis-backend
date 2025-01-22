# app/controllers/api/v1/users/sessions_controller.rb
class Api::V1::Users::SessionsController < Devise::SessionsController
  rescue_from StandardError do |e|
    Rails.logger.error "Session Error: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    Rails.logger.info "Login attempt for email: #{sign_in_params[:email]}"

    self.resource = warden.authenticate!(auth_options)

    if resource
      sign_in(resource_name, resource)
      Rails.logger.info "User authenticated: #{resource.id}"

      token = request.env['warden-jwt_auth.token']
      Rails.logger.info "Generated token: #{token.present? ? 'Yes' : 'No'}"

      render json: {
        data: {
          user: {
            id: resource.id,
            email: resource.email,
            username: resource.username,
            created_at: resource.created_at.strftime('%Y-%m-%d')
          },
          token: token
        },
        status: { code: 200, message: 'Logged in successfully.' }
      }
    else
      render json: {
        status: { code: 401, message: 'Invalid credentials.' }
      }, status: :unauthorized
    end
  end

  def destroy
    begin
      Rails.logger.info "Logout attempt for user: #{current_user&.id}"

      if current_user
        current_user.update_column(:jti, SecureRandom.uuid)
        sign_out current_user
        render json: {
          status: { code: 200, message: 'Logged out successfully.' }
        }
      else
        render json: {
          status: { code: 200, message: 'No active session.' }
        }
      end
    rescue => e
      Rails.logger.error "Logout Error: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  private

  def respond_to_on_destroy
    head :no_content
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
