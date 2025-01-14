# app/controllers/api/v1/assets_controller.rb
module Api
  module V1
    class AssetsController < ApplicationController
      skip_before_action :authenticate_token!, only: [:show]  # Si vous avez une authentification

      def show
        file_path = Rails.root.join('app', 'assets', 'images', 'teams', params[:filename])
        if File.exist?(file_path)
          send_file file_path, disposition: 'inline'
        else
          head :not_found
        end
      end
    end
  end
end
