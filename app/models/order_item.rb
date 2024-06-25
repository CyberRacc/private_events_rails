class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :ticket

  validates :quantity, :price, presence: true
end
