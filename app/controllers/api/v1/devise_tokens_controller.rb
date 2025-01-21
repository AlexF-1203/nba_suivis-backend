module Api
  module V1
    class DeviceTokensController < ApplicationController
      def create
        token = current_user.device_tokens.find_or_initialize_by(token: params[:token])
        token.platform = params[:platform]
        token.active = true

        if token.save
          render json: { message: 'Device token registered successfully' }, status: :created
        else
          render json: { errors: token.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
