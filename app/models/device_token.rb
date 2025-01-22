# app/models/device_token.rb
class DeviceToken < ApplicationRecord
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
end
