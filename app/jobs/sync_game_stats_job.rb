# app/jobs/sync_game_stats_job.rb
class SyncGameStatsJob < ApplicationJob
  queue_as :default

  def perform
    api_service = ApiSportsService.new
    games_without_stats = Game.where(status: "Finished")

    games_without_stats.find_each do |game|
      # Skip if stats already exist for this game
      if PlayerGame.exists?(game_id: game.id)
        Rails.logger.info "Stats already exist for game #{game.id}, skipping..."
        next
      end

      Rails.logger.info "Syncing stats for game #{game.id}..."
      api_service.get_game_statistics(game.game_api_id)
    end
  end
end
