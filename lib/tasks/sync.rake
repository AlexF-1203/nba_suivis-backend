namespace :sync do
  desc "Synchronize NBA games and players"
  task nba: :environment do
    api_service = ApiSportsService.new

    puts "Synchronizing games..."
    api_service.sync_games

    puts "Synchronizing players..."
    api_service.sync_players

    puts "Synchronization completed!"
  end

  desc "Test API configuration"
  task test_config: :environment do
    puts "API Key présente: #{!ENV['API_SPORTS_KEY'].nil?}"
    puts "API Key: #{ENV['API_SPORTS_KEY']&.first(6)}..."

    api_service = ApiSportsService.new
    puts "Headers configurés: #{api_service.instance_variable_get(:@options)[:headers]}"
  end
end
