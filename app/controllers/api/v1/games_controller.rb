# app/controllers/api/v1/games_controller.rb
class Api::V1::GamesController < Api::V1::ApplicationController
  def index
    @games = Game.all
    render json: @games
  end

  def show
    @game = Game.find(params[:id])
    render json: @game
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      render json: @game, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:team_1_id, :team_2_id, :date, :team_1_score, :team_2_score)
  end
end
