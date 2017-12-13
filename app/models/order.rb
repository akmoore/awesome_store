class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  PAYMENT_TYPES = ['Check', 'Credit Card', 'PayPal', 'COD', 'Wampum'].sort

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item #=> take the new version of line item and push into an array 'line_items'
    end
  end

  def subtotal
    line_items.select("SUM(quantity * price) AS sum")[0].sum
  end
end

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :text
#  pay_type   :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
