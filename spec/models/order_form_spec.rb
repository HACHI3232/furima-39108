require 'rails_helper'
RSpec.describe OrderForm, type: :model do
  describe '配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @order_form = FactoryBot.build(:order_form, user_id: user.id)
    end

    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_form).to be_valid
      end

      it 'user_idが空でなければ保存できる' do
        @order_form.user_id = 1
        expect(@order_form).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @order_form.item_id = 1
        expect(@order_form).to be_valid
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列の組み合わせであれば保存できること' do
        @order_form.postcode = '123-4560'
        expect(@order_form).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できること' do
        @order_form.prefecture_id = 1
        expect(@order_form).to be_valid
      end
      it '市区町村が空でなければ保存できること' do
        @order_form.city = '相模原市'
        expect(@order_form).to be_valid
      end
      it '番地が空でなければ保存できること' do
        @order_form.block = '緑区123'
        expect(@order_form).to be_valid
      end
      it '建物名が空であっても保存できること' do
        @order_form.building = nil
        expect(@order_form).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できること' do
        @order_form.phone_number = 12_345_678_910
        expect(@order_form).to be_valid
      end

    context '配送先情報の保存ができないとき' do
      it "郵便番号が空欄だと保存できないこと" do
        @order_form.postcode = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode can't be blank")
      end

      it 'user_idが空だと保存できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end

      it "郵便番号は、「3桁ハイフン4桁」の半角文字列でないと保存できないこと" do
        @order_form.postcode = "1234567"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode is invalid")
        @order_form.postcode = "123-456"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode is invalid")
        @order_form.postcode = "123-45678"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode is invalid")
      end

      it "都道府県が空欄だと保存できないこと" do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "電話番号は、10桁以上11桁以内の半角数値のみでないと保存できないこと" do
        @order_form.phone_number = "123456789"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
        @order_form.phone_number = "123456789012"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
        @order_form.phone_number = "123-456-789"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
      end
    end
    end
  end
end
