class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :favorite_teams
  has_many :teams, through: :favorite_teams
  has_many :device_tokens, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  # Ajoutez ces validations
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def self.revoke_jwt(payload, user)
    # Utilisons update_column au lieu de update! pour éviter la validation
    user.update_column(:jti, SecureRandom.uuid)
  end

  def on_jwt_dispatch(_token, _payload)
    # Ne rien faire ici, car le jti est déjà géré lors de la création du user
  end
end
