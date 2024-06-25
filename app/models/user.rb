class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :orders
  has_many :event_attendees
  has_many :attended_events, through: :event_attendees, source: :event

  validates :username, presence: true, uniqueness: true
end
