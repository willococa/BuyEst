class Order < ApplicationRecord
  enum status: { pending: 0, completed: 1, cancelled: 2 }
  belongs_to :client
  has_many :order_items
  has_many :products, through: :order_items

  def total_price
    Rails.cache.fetch("order/#{id}/total_price") do
      order_items.sum(:quantity)
    end
  end

  def items_count
    Rails.cache.fetch("order/#{id}/item_count") do
      order_items.count
    end
  end
end
