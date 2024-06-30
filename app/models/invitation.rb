class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event_id, uniqueness: { scope: :user_id, message: "User has already been invited to this event" }

  enum status: { pending: 'pending', accepted: 'accepted', rejected: 'rejected' }

  scope :pending, -> { where(status: 'pending') }
end
