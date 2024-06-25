class Ticket < ApplicationRecord
  belongs_to :event
  has_many :order_items

  validates :name, :price, :quantity, presence: true
end
