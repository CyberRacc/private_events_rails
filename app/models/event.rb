class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets
  has_many :orders
  has_many :event_attendees
  has_many :attendees, through: :event_attendees, source: :user

  validates :title, :start_time, :end_time, presence: true
end
