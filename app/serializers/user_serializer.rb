class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :created_at

  # Ajouter des attributs conditionnels
  attribute :token, if: :show_token?

  # Ajouter des méthodes personnalisées
  def show_token?
    object.admin?
  end

  # Formater des attributs
  def created_at
    if object.created_at.present?
      object.created_at.strftime('%Y-%m-%d')
    else
      nil
    end
  end
end
