class Api::V1::FavoritePlayersController < Api::V1::ApplicationController
  def create
    @favorite = current_user.favorite_players.build(favorite_player_params)
    if @favorite.save
      render json: @favorite, status: :created
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = current_user.favorite_players.find(params[:id])
    @favorite.destroy
    head :no_content
  end

  private

  def favorite_player_params
    params.require(:favorite_player).permit(:player_id)
  end
end
