class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events, class_name: 'Event', foreign_key: 'user_id', dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :event_attendees, dependent: :destroy
  has_many :attended_events, through: :event_attendees, source: :event

  has_many :invitations, dependent: :destroy
  has_many :invited_events, through: :invitations, source: :event

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
