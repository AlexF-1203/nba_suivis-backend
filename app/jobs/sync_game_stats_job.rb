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

      begin
        api_service.get_game_statistics(game.game_api_id)

        # Ajouter un délai de 20 secondes entre chaque requête
      rescue => e
        Rails.logger.error "Error syncing stats for game #{game.id}: #{e.message}"
        # Continue to next game even if there's an error
      end
    end
  end
end
