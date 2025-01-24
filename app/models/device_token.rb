# app/models/device_token.rb
class DeviceToken < ApplicationRecord
  after_save :check_token_validity

  belongs_to :user

  validates :token, presence: true
  validates :platform, presence: true
  validates :active, inclusion: { in: [true, false] }

  before_save :ensure_unique_active_token

  private

  def ensure_unique_active_token
    if active?
      user.device_tokens.where.not(id: id).update_all(active: false)
    end
  end

  def check_token_validity
    if details&.dig('error') == 'DeviceNotRegistered'
      self.update_column(:active, false)
    end
  end
end
