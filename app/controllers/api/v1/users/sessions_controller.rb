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
    begin
      # Supprime la validation du token pour la déconnexion
      skip_authorization

      if current_user
        # Mise à jour du JTI sans validation
        current_user.update_column(:jti, SecureRandom.uuid)
        sign_out(current_user)

        render json: {
          status: 200,
          message: "Déconnexion réussie"
        }
      else
        render json: {
          status: 200,
          message: "Déjà déconnecté"
        }
      end
    rescue => e
      Rails.logger.error("Erreur de déconnexion: #{e.message}")
      render json: {
        status: 500,
        message: "Erreur lors de la déconnexion"
      }, status: :internal_server_error
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
            username: resource.username,
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
