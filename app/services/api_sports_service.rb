class ApiSportsService
  include HTTParty
  base_uri 'https://api-nba-v1.p.rapidapi.com'

  def initialize
    @options = {
      headers: {
        'X-RapidAPI-Host' => 'api-nba-v1.p.rapidapi.com',
        'X-RapidAPI-Key' => ENV['API_SPORTS_KEY']
      }
    }
    Rails.logger.debug "API Headers: #{@options[:headers].inspect}"
  end

  def sync_games
    Rails.logger.info "Début de la synchronisation des matchs"
    begin

      response = self.class.get('/games', @options.merge(
        query: { date: Time.current.strftime('%Y-%m-%d') }
      ))

      Rails.logger.debug "Response status: #{response.code}"
      games_data = handle_response(response)

      ActiveRecord::Base.transaction do
        Game.destroy_all
        games_data['response'].each do |game_data|
          # home_team = Team.find_by(name: game_data['teams']['home']['name'])
          # away_team = Team.find_by(name: game_data['teams']['visitors']['name'])

        #   home_team.update!(
        #   wins: game_data['scores']['home']["win"],
        #   losses: game_data['scores']['home']['loss']
        # )

        # away_team.update!(
        #   wins: game_data['scores']['visitors']["win"],
        #   losses: game_data['scores']['visitors']['loss']
        # )


          game = Game.find_or_initialize_by(
            team_1: Team.find_by(name: game_data['teams']['home']['name']),
            team_2: Team.find_by(name: game_data['teams']['visitors']['name']),
            date: game_data['date']['start']
          )

          game.update!(
            team_1_score: game_data['scores']['home']['points'],
            team_2_score: game_data['scores']['visitors']['points'],
            team_1_q1: game_data['scores']['home']['linescore'][0],
            team_1_q2: game_data['scores']['home']['linescore'][1],
            team_1_q3: game_data['scores']['home']['linescore'][2],
            team_1_q4: game_data['scores']['home']['linescore'][3],
            team_2_q1: game_data['scores']['visitors']['linescore'][0],
            team_2_q2: game_data['scores']['visitors']['linescore'][1],
            team_2_q3: game_data['scores']['visitors']['linescore'][2],
            team_2_q4: game_data['scores']['visitors']['linescore'][3],
            status: game_data['status']['long']
          )
        end
      end
    rescue => e
      Rails.logger.error "Erreur lors de la synchronisation: #{e.message}"
      raise e
    end
  end

  def sync_players
    Rails.logger.info "Début de la synchronisation des joueurs"
    begin
      response = self.class.get('/players', @options.merge(
        query: { season: '2023-2024' }
      ))

      players_data = handle_response(response)

      ActiveRecord::Base.transaction do
        players_data['response'].each do |player_data|
          next unless player_data['active']

          player = Player.find_or_initialize_by(
            name: "#{player_data['firstname']} #{player_data['lastname']}"
          )

          player.update!(
            team: Team.find_by(name: player_data['team']['name']),
            profile: player_data['pos'],
            image: player_data['image']
          )
        end
      end
    rescue => e
      Rails.logger.error "Erreur lors de la synchronisation des joueurs: #{e.message}"
      raise e
    end
  end

  private

  def handle_response(response)
    Rails.logger.debug "Response body: #{response.body}"
    if response.success?
      JSON.parse(response.body)
    else
      Rails.logger.error "API Error - Status: #{response.code}, Body: #{response.body}"
      raise "API request failed: #{response.code} - #{response.message}"
    end
  end
end
