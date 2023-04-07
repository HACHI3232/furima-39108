require 'rails_helper'
RSpec.describe OrderForm, type: :model do
  describe '配送先情報の購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
    end

    context '配送先情報の購入ができるとき' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@order_form).to be_valid
      end

      it 'user_idが空でなければ購入できること' do
        @order_form.user_id = 1
        expect(@order_form).to be_valid
      end

      it 'item_idが空でなければ購入できること' do
        @order_form.item_id = 1
        expect(@order_form).to be_valid
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列の組み合わせであれば購入できること' do
        @order_form.postcode = '123-4560'
        expect(@order_form).to be_valid
      end

      it '市区町村が空でなければ購入できること' do
        @order_form.city = '相模原市'
        expect(@order_form).to be_valid
      end

      it '番地が空でなければ購入できること' do
        @order_form.block = '緑区123'
        expect(@order_form).to be_valid
      end

      it '建物名が空でも購入できること' do
        @order_form.building = nil
        expect(@order_form).to be_valid
      end

      it '電話番号が11番桁以内かつハイフンなしであれば購入できること' do
        @order_form.phone_number = 12_345_678_910
        expect(@order_form).to be_valid
      end
    end

    context '配送先情報の購入ができないとき' do
      it '郵便番号が空欄だと購入できないこと' do
        @order_form.postcode = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode can't be blank")
      end

      it 'user_idが空だと購入できないこと' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと購入できないこと' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end

      it '郵便番号が空では購入できないこと' do
        @order_form.postcode = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode can't be blank")
      end

      it '郵便番号が半角ハイフンを含む形でなければ購入できないこと' do
        @order_form.postcode = '123-456'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postcode is invalid')
      end

      it '都道府県が空欄だと購入できないこと' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が未選択の場合購入できないこと' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Prefecture を選択して下さい')
      end

      it '市区町村が空では購入できないこと' do
        @order_form.block = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Block can't be blank")
      end

      it '番地が空では購入できない' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it '電話番号が空では購入できないこと' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が9桁以下では購入できないこと' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号は、10桁以上11桁以内の半角数値のみでないと購入できないこと' do
        @order_form.phone_number = '123456789012'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号に半角数字以外が含まれている場合は購入できないこと（※半角数字以外が一文字でも含まれていれば良い）' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'トークンが空だと購入できないこと' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていなければ購入できないこと' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていなければ購入できないこと' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
