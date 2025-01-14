class Api::V1::FavoriteTeamsController < Api::V1::ApplicationController
  def create
    @favorite = current_user.favorite_teams.build(favorite_team_params)
    if @favorite.save
      render json: @favorite, status: :created
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = current_user.favorite_teams.find(params[:id])
    @favorite.destroy
    head :no_content
  end

  private

  def favorite_team_params
    params.require(:favorite_team).permit(:team_id)
  end
end
