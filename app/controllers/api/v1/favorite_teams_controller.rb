class Api::V1::FavoriteTeamsController < Api::V1::ApplicationController
  def index
    @favorite_teams = current_user.favorite_teams
    render json: @favorite_teams
  end

  def create
    @favorite = current_user.favorite_teams.build(team_id: params[:team_id])
    if @favorite.save
      render json: @favorite, status: :created
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = current_user.favorite_teams.find_by(team_id: params[:id])
    if @favorite
      @favorite.destroy
      head :no_content
    else
      render json: { error: 'Favorite not found' }, status: :not_found
    end
  end
end
