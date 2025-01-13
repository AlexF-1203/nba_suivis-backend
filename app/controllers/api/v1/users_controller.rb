class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer
  end
end
