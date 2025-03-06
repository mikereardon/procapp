# app/models/line_item.rb
class LineItem < ApplicationRecord
  belongs_to :proposal

  validates :description, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def total_price
    quantity * unit_price
  end
end
