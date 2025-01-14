# app/controllers/api/v1/players_controller.rb
class Api::V1::PlayersController < Api::V1::ApplicationController
  def index
    @players = Player.all
    render json: @players
  end

  def show
    @player = Player.find(params[:id])
    render json: @player
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      render json: @player, status: :created
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :profile, :team_id)
  end
end

# app/controllers/api/v1/favorite_players_controller.rb

# app/controllers/api/v1/favorite_teams_controller.rb


# app/controllers/api/v1/games_controller.rb

