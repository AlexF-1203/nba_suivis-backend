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
        games_data['response'].each do |game_data|
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
            status: game_data['status']['long'],
            game_api_id: game_data['id']
          )
        end
      end
    rescue => e
      log_sync_error(e)
      raise e
    end
  end

  def get_game_statistics(game_api_id)
    PlayerGame.where(game: Game.find_by(game_api_id: game_api_id)).destroy_all
    response = self.class.get('/players/statistics', @options.merge(
      query: { game: game_api_id }
    ))

    stats_data = handle_response(response)
    game = Game.find_by(game_api_id: game_api_id)

    ActiveRecord::Base.transaction do
      stats_data['response'].each do |stat|

        if stat['player'] && stat['player']['firstname'] && stat['player']['lastname']
          player_name = "#{stat['player']['firstname']} #{stat['player']['lastname']}".strip
          if player_name.present?
            team = Team.find_by(name: stat['team']['name'])
            player = Player.find_or_create_by(name: player_name) do |p|
              p.team = team
            end
          end
        else
          puts "Données de joueur manquantes pour stat: #{stat.inspect}"
        end
        team = Team.find_by(name: stat['team']['name'])

        next unless player && team && game

        player_game = PlayerGame.find_or_initialize_by(
          player: player,
          game: game,
          team: team
        )

        player_game.update!(
          points: stat['points'],
          minutes: stat['min'],
          rebounds: stat['totReb'],
          assists: stat['assists'],
          blocks: stat['blocks'],
          steals: stat['steals'],
          offensive_rebounds: stat['offReb'],
          turnovers: stat['turnovers'],
          personal_fouls: stat['pFouls'],
          three_point_percentage: stat['tpp'].to_d,
          defensive_rebounds: stat['defReb'],
          free_throw_percentage: stat['ftp'].to_d,
          true_shooting_percentage: stat['fgp'].to_d
        )
      end
    end
  rescue => e
    Rails.logger.error "Error syncing game statistics: #{e.message}"
    raise e
  end
  # def sync_players
  #   Rails.logger.info "Début de la synchronisation des joueurs"
  #   begin
  #     response = self.class.get('/players', @options.merge(
  #       query: { season: '2023-2024' }
  #     ))

  #     players_data = handle_response(response)

  #     ActiveRecord::Base.transaction do
  #       players_data['response'].each do |player_data|
  #         next unless player_data['active']

  #         player = Player.find_or_initialize_by(
  #           name: "#{player_data['firstname']} #{player_data['lastname']}"
  #         )

  #         player.update!(
  #           team: Team.find_by(name: player_data['team']['name']),
  #           profile: player_data['pos'],
  #           image: player_data['image']
  #         )
  #       end
  #     end
  #   rescue => e
  #     Rails.logger.error "Erreur lors de la synchronisation des joueurs: #{e.message}"
  #     raise e
  #   end
  # end

  private

  def convert_percentage(value)
    return 0 if value.nil? || value.to_s.empty?

    # Si la valeur est déjà un nombre décimal, la retourner directement
    return value if value.is_a?(Numeric)

    # Enlever le symbole % s'il existe et convertir en décimal
    value.to_s.gsub('%', '').strip.to_d
  rescue
    0 # En cas d'erreur de conversion, retourner 0
  end

  def log_sync_error(error)
    error_message = "Erreur lors de la synchronisation: #{error.message}"
    error_message += "\nTrace: #{error.backtrace.first(5).join("\n")}"
    Rails.logger.error(error_message)
  end

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
