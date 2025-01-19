class Api::V1::PlayerGamesController < Api::V1::ApplicationController
  def index
    @player_games = PlayerGame.where(game_id: params[:game_id])
                            .includes(:player, :team)
    render json: @player_games
  end
end
