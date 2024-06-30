class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :event_attendees, dependent: :destroy
  has_many :attendees, through: :event_attendees, source: :user
  has_many :invitations, dependent: :destroy
  has_many :invited_users, through: :invitations, source: :user

  validates :title, :description, :start_time, :end_time, :location, presence: true
  validate :start_time_cannot_be_too_soon, :end_time_cannot_be_before_start_time, :start_and_end_time_must_be_in_valid_range

  # Scopes are a way to filter your database queries in a more readable way.
  # Here, we have defined two scopes: past and upcoming.
  # The past scope returns all events that have already happened, ordered by start_time in descending order.
  # The upcoming scope returns all events that are yet to happen, ordered by start_time in ascending order.
  scope :past, -> { where("start_time < ?", Time.now).order(start_time: :desc) }
  scope :upcoming, -> { where("start_time >= ?", Time.now).order(start_time: :asc) }
  scope :private_events, -> { where(private: true) }
  scope :public_events, -> { where(private: false) }

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
