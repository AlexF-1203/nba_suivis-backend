# app/controllers/api/v1/assets_controller.rb
module Api
  module V1
    class AssetsController < ApplicationController
      skip_before_action :authenticate_token!, only: [:show]

      def show
        file_path = Rails.root.join('public/images/teams', "#{params[:filename]}.png")

        Rails.logger.debug "Looking for file at: #{file_path}"

        if File.exist?(file_path)
          send_file file_path, disposition: 'inline', type: 'image/png'
        else
          render json: { error: "Image not found at: #{file_path}" }, status: :not_found
        end
      end
    end
  end
end
