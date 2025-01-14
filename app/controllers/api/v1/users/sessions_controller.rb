# app/controllers/api/v1/users/sessions_controller.rb
class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_signed_out_user
  before_action :authenticate_user!, only: :destroy

  # Ajoutons cette méthode pour déboguer
  def create
    Rails.logger.info "Session params: #{params.inspect}"
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    token = request.env['warden-jwt_auth.token']
    Rails.logger.info "Generated token: #{token}"
    respond_with(resource)
  end

  def destroy
    if current_user
      # Désactivons temporairement la validation pour la mise à jour du JTI
      current_user.update_column(:jti, SecureRandom.uuid)
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      render json: {
        status: 200,
        message: "Logged out successfully."
      }
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
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
    else
      render json: {
        status: 401,
        message: "Invalid email or password."
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    head :no_content
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  # Ajoutons cette méthode pour s'assurer que les paramètres sont correctement structurés
  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
