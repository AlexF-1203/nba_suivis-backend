class Api::V1::ApplicationController < ApplicationController
  before_action :authenticate_token!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authenticate_token!
    token = request.headers['Authorization']&.split(' ')&.last
    # Validation du token JWT par exemple
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end
