class OrderAddress < ApplicationRecord
  belongs_to :order

  with_options presence: true do
    validates :postcode, :prefecture_id, :city, :block
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 0,}
    validates :phone_number, format: { with: /\A\d{10,11}\z/,}
  end
end
