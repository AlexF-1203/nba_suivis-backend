# app/controllers/api/v1/device_tokens_controller.rb
module Api
  module V1
    class DeviceTokensController < Api::V1::ApplicationController
      def create
        @device_token = current_user.device_tokens.find_or_initialize_by(
          token: device_token_params[:token]
        )

        @device_token.assign_attributes(
          platform: device_token_params[:platform],
          active: true
        )

        if @device_token.save
          render json: { message: 'Device token registered successfully' }, status: :created
        else
          render json: { errors: @device_token.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def cleanup
        DeviceToken.destroy_all
        render json: { message: "All tokens cleaned up" }
      end

      private

      def device_token_params
        params.require(:device_token).permit(:token, :platform)
      end
    end
  end
end
