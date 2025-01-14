class FavoritePlayerSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :player
  belongs_to :user
end
