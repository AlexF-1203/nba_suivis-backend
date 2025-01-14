class GameSerializer < ActiveModel::Serializer
  attributes :id, :date, :score

  belongs_to :team_1, class_name: 'Team'
  belongs_to :team_2, class_name: 'Team'
end
