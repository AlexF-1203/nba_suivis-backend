class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :created_at

  # Ajouter des associations
  has_many :teams
  belongs_to :favorite_team

  # Ajouter des attributs conditionnels
  attribute :token, if: :show_token?

  # Ajouter des méthodes personnalisées
  def show_token?
    scope.admin?
  end

  # Formater des attributs
  def created_at
    object.created_at.strftime('%Y-%m-%d')
  end
end
