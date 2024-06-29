class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets
  has_many :orders
  has_many :event_attendees
  has_many :attendees, through: :event_attendees, source: :user

  validates :title, :description, :start_time, :end_time, :location, presence: true
  validate :start_time_cannot_be_too_soon, :end_time_cannot_be_before_start_time, :start_and_end_time_must_be_in_valid_range

  private

  def start_time_cannot_be_too_soon
    if start_time.present? && start_time < Time.now + 1.week
      errors.add(:start_time, "must be at least one week from now")
    end
  end

  def end_time_cannot_be_before_start_time
    if end_time.present? && end_time < start_time
      errors.add(:end_time, "can't be before the start time")
    end
  end

  def start_and_end_time_must_be_in_valid_range
    current_year = Time.now.year
    max_year = current_year + 5

    if start_time.present? && (start_time.year < current_year || start_time.year > max_year)
      errors.add(:start_time, "must be within the next five years")
    end

    if end_time.present? && (end_time.year < current_year || end_time.year > max_year)
      errors.add(:end_time, "must be within the next five years")
    end
  end
end
