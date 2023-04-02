require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  context '内容に問題ない場合' do
    it "正常に保存できること" do
      expect(@order_address).to be_valid
    end
  end

  context '内容に問題がある場合' do

    it "郵便番号が必須であること" do
      @order_address.postcode = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
    end

    it "郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能であること" do
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

    it "都道府県が必須であること" do
      @order_address.prefecture_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end

    it "市区町村が必須であること" do
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it "番地が必須であること" do
      @order_address.block = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Block can't be blank")
    end

    it "建物名は任意であること" do
      @order_address.building = nil
      expect(@order_address).to be_valid
    end

    it "電話番号が必須であること" do
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it "電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと" do
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
