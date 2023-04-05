class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  with_options presence: true do
    validates :image, :name, :description, :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_day_id
  end
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_day_id
  end

  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_payer
  belongs_to :shipping_day

  belongs_to :user
  has_one_attached :image
  has_one :order
end
