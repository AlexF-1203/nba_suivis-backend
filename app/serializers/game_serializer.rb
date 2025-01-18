class GameSerializer < ActiveModel::Serializer
  attributes :id, :date, :team_1_score, :team_2_score,
             :team_1_q1, :team_1_q2, :team_1_q3, :team_1_q4,
             :team_2_q1, :team_2_q2, :team_2_q3, :team_2_q4,
             :status

  belongs_to :team_1, class_name: 'Team'
  belongs_to :team_2, class_name: 'Team'
end
