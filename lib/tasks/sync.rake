namespace :sync do
  desc "Synchronize NBA games and players"
  task nba: :environment do
    api_service = ApiSportsService.new

    puts "Starting full NBA synchronization..."
    begin
      puts "Synchronizing games..."
      api_service.sync_games
      puts "Games synchronization completed!"

      puts "Full synchronization completed successfully!"
    rescue => e
      puts "Error during synchronization: #{e.message}"
      puts e.backtrace
      raise e
    end
  end

  desc "Synchronize statistics for a specific game"
  task :game_stats, [:game_id] => :environment do |t, args|
    if args[:game_id].blank?
      puts "Please provide a game_id. Usage: rails sync:game_stats[game_id]"
      exit
    end

    api_service = ApiSportsService.new
    puts "Synchronizing statistics for game #{args[:game_id]}..."
    begin
      api_service.get_game_statistics(args[:game_id])
      puts "Game statistics synchronization completed!"
    rescue => e
      puts "Error during synchronization: #{e.message}"
      puts e.backtrace
      raise e
    end
  end

  desc "Synchronize statistics for all existing games"
  task all_games_stats: :environment do
    api_service = ApiSportsService.new
    games = Game.where.not(game_api_id: nil)

    puts "Starting synchronization for #{games.count} games..."
    games.each_with_index do |game, index|
      begin
        puts "Processing game #{index + 1}/#{games.count} (API ID: #{game.game_api_id})"
        api_service.get_game_statistics(game.game_api_id)
        puts "✓ Completed game #{game.game_api_id}"
      rescue => e
        puts "× Error processing game #{game.game_api_id}: #{e.message}"
      end
    end
    puts "All games processing completed!"
  end
end
