# app/controllers/api/v1/users/sessions_controller.rb
class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: {
        user: {
          id: resource.id,
          email: resource.email,
          created_at: resource.created_at.strftime('%Y-%m-%d')
        },
        token: request.env['warden-jwt_auth.token']
      }
    }
  end

  def log_out_success
    render json: { message: 'Logged out successfully.' }
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end
end
