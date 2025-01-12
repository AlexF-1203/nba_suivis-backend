class Api::V1::TeamsController < ApplicationController
  def index
    teams = Team.all
    render json: teams
  end
end
