class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # カラムのバリデーション(空だと登録できない)
  with_options presence: true do
    validates :image, :name, :description, :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_day_id
  end
  # 価格のバリデーション（300円以上、9.999.999円以下）でないと登録出来ない
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # プルダウンのバリデーション未選択（id=0）の場合登録出来ない
  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_day_id
  end

  # アソシエーション
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_payer
  belongs_to :shipping_day

  belongs_to :user
  has_one_attached :image
end

# validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
# validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
# validates :shipping_payer_id, numericality: { other_than: 1 , message: "can't be blank"}
# validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
# validates :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"}

# with_options numericality: { other_than: 1 , message: "can't be blank"} do
#   validates :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_day_id
