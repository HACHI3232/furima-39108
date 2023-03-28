class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  #テーブルのバリデーション(空だと登録できない)
  with_options presence: true do
    validates :image, :name, :description, :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_day_id
  end

  #価格のバリデーション
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than: 9_999_999 }, format: { with: /\A[0-9]+\z/, message: "半角数字のみ登録可能です" }

  #プルダウンのバリデーション
  with_options numericality: { other_than: 1 , message: "can't be blank"} do
    validates :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_day_id
  end




  #アソシエーション
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_payer
  belongs_to :shipping_day


  belongs_to :user
  
  has_one_attached :image

end
