require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it '郵便番号が「3桁ハイフン4桁」の半角文字列の組み合わせであれば保存できること' do
        @order_address.postcode = '123-4560'
        expect(@order_address).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できること' do
        @order_address.prefecture_id = 1
        expect(@order_address).to be_valid
      end
      it '市区町村が空でなければ保存できること' do
        @order_address.city = '相模原市'
        expect(@order_address).to be_valid
      end
      it '番地が空でなければ保存できること' do
        @order_address.block = '緑区123'
        expect(@order_address).to be_valid
      end
      it '建物名が空であっても保存できること' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できること' do
        @order_address.phone_number = 12_345_678_910
        expect(@order_address).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it "郵便番号が空欄だと保存できないこと" do
        @order_address.postcode = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
      end

      it "郵便番号は、「3桁ハイフン4桁」の半角文字列でないと保存できないこと" do
        @order_address.postcode = "1234567"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid")
        @order_address.postcode = "123-456"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid")
        @order_address.postcode = "123-45678"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid")
      end

      it "都道府県が空欄だと保存できないこと" do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "市区町村が空欄だと保存できないこと" do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it "番地が空欄だと保存できないこと" do
        @order_address.block = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block can't be blank")
      end

      it "建物名が空欄だと保存できないこと" do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end

      it "電話番号が空欄だと保存できないこと" do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it "電話番号は、10桁以上11桁以内の半角数値のみでないと保存できないこと" do
        @order_address.phone_number = "123456789"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
        @order_address.phone_number = "123456789012"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
        @order_address.phone_number = "123-456-789"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end
