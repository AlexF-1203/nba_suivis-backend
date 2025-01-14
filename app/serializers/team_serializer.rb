class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :conference, :rank, :logo_url

  has_many :players
  has_many :games, foreign_key: 'team_1_id'
end
