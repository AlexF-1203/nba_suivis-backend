class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :profile, :image

  belongs_to :team
end
