class Order < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :order_items

  validates :total_amount, :status, presence: true
end
