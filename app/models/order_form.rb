  class OrderForm
    include ActiveModel::Model
    attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number,:token

    with_options presence: true do
      validates :postcode, :prefecture_id, :city, :block,:user_id,:item_id,:token
      validates :postcode, format: { with: /\A\d{3}-\d{4}\z/ }
      validates :prefecture_id, numericality: { other_than: 0,}
      validates :phone_number, format: { with: /\A\d{10,11}\z/,}
    end

    def save
      order = Order.create(user_id: user_id, item_id: item_id)
      OrderAddress.create(postcode:postcode, prefecture_id:prefecture_id, city:city, block:block, building:building, phone_number:phone_number,order_id: order.id)
    end
  end
