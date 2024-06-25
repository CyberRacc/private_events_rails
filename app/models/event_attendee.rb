class EventAttendee < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :checked_in, inclusion: { in: [true, false] }
end
