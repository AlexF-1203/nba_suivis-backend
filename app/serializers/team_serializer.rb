class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :logo_url

  has_many :players
  has_many :games
end
