class EventAttendee < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :checked_in, inclusion: { in: [true, false] }
  validates :user_id, uniqueness: { scope: :event_id, message: "is already attending this event" }
  validate :event_is_finished

  private

  def event_is_finished
    if event.present? && event.start_time < Time.now
      errors.add(:event, "has already finished")
    end
  end

end
