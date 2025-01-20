class SyncGamesJob < ApplicationJob
  queue_as :default

  def perform
    api_service = ApiSportsService.new
    api_service.sync_games
    # Programme le job des stats pour 5 minutes plus tard
    SyncGameStatsJob.set(wait: 5.minutes).perform_later
  end
end

# app/jobs/sync_game_stats_job.rb
class SyncGameStatsJob < ApplicationJob
  queue_as :default

  def perform
    api_service = ApiSportsService.new
    Game.where(status: "Finished").find_each do |game|
      api_service.get_game_statistics(game.game_api_id)
    end
  end
end
