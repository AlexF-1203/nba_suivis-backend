# app/jobs/sync_games_job.rb
class SyncGamesJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "Starting SyncGamesJob at #{Time.current}"
    begin
      api_service = ApiSportsService.new
      api_service.sync_games
      Rails.logger.info "Games sync completed successfully"

      # Au lieu d'utiliser require_dependency, utilisez directement la classe
      # Assurez-vous que les deux fichiers sont dans le même dossier app/jobs/
      SyncGameStatsJob.set(wait: 1.minutes).perform_later

      Rails.logger.info "Stats job scheduled successfully"
    rescue => e
      Rails.logger.error "Error in SyncGamesJob: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      raise e
    end
  end
end
