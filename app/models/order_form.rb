  class OrderForm
    include ActiveModel::Model
    attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number

    def save
      order = Order.create(user_id: user_id, item_id: item_id)
      OrderAddress.create(postcode:postcode, prefecture_id:prefecture_id, city:city, block:block, building:building, phone_number:phone_number,order_id: order.id)
    end
  end
