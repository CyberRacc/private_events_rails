class EventAttendee < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :checked_in, inclusion: { in: [true, false] }
  validates :user_id, uniqueness: { scope: :event_id, message: "is already attending this event" }
end
