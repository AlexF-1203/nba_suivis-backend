class Api::V1::FavoritePlayersController < Api::V1::ApplicationController
  def index
    @favorite_players = current_user.favorite_players
    render json: @favorite_players
  end

  def create
    @favorite = current_user.favorite_players.build(player_id: params[:player_id])
    if @favorite.save
      render json: @favorite, status: :created
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = current_user.favorite_players.find_by(player_id: params[:id])
    if @favorite
      @favorite.destroy
      head :no_content
    else
      render json: { error: 'Favorite not found' }, status: :not_found
    end
  end
end
