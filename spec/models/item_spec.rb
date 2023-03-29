require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.create(:item)
    end

    context '出品登録ができるとき' do
      it '全ての項目の入力が存在すれば登録できること' do
        expect(@item).to be_valid
      end
    end

    context '出品登録できない場合' do
      it '商品画像が１枚添付されてないと出品登録' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空欄だと出品登録が出来ない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明欄が空欄だと出品登録出来ない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報が空欄だと出品登録が出来ない' do
        @item.category = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態が空欄だと出品登録が出来ない' do
        @item.condition = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担が空欄だと出品登録が出来ない' do
        @item.shipping_payer = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping payer can't be blank")
      end
      it '発送の地域が空欄だと出品登録が出来ない' do
        @item.prefecture = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'カテゴリーが「---」以外であれば登録できる' do
        @item.category_id = 1
        expect(@item).to be_valid
      end
      it '商品の状態が「---」以外であれば登録できる' do
        @item.condition_id = 1
        expect(@item).to be_valid
      end
      it '配送料の負担が「---」以外であれば登録できる' do
        @item.shipping_payer_id = 1
        expect(@item).to be_valid
      end
      it '発送元の地域が「---」以外であれば登録できる' do
        @item.prefecture_id = 1
        expect(@item).to be_valid
      end
      it '発送までの日数が「---」以外であれば登録できる' do
        @item.shipping_day_id = 1
        expect(@item).to be_valid
      end
      it '価格が空欄だと出品登録が出来ない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が半角数値以外だと出品登録が出来ない' do
        @item.price = 'あｱa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格の範囲が、300円未満だと出品できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格の範囲が、9,999,999円を超えると出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 9999999')
      end
    end
  end
end
