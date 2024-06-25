class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets
  has_many :orders
  has_many :event_attendees
  has_many :attendees, through: :event_attendees, source: :user

  validates :title, :description, :start_time, :end_time, :location, presence: true
  validate :start_time_cannot_be_in_the_past, :end_time_cannot_be_before_start_time

  private

  def start_time_cannot_be_in_the_past
    if start_time.present? && start_time < Time.now
      errors.add(:start_time, "can't be in the past")
    end
  end

  def end_time_cannot_be_before_start_time
    if end_time.present? && end_time < start_time
      errors.add(:end_time, "can't be before the start time")
    end
  end
end
