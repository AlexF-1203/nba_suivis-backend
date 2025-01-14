class GameSerializer < ActiveModel::Serializer
  attributes :id, :date, :team_1_score, :team_2_score

  belongs_to :team_1, class_name: 'Team'
  belongs_to :team_2, class_name: 'Team'
end
