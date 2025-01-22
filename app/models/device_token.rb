class DeviceToken < ApplicationRecord
  belongs_to :user
  validates :token, presence: true, uniqueness: true
  validates :platform, presence: true
  validates :active, inclusion: { in: [true, false] }
end
