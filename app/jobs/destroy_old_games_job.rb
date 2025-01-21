# app/jobs/destroy_old_games_job.rb
class DestroyOldGamesJob < ApplicationJob
  queue_as :default

  def perform
    PlayerGame.destroy_all
    Game.destroy_all
    Rails.logger.info "All Games and PlayerGames have been destroyed at #{Time.current}"
  end
end
