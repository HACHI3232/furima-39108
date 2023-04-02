FactoryBot.define do
  factory :order_address do
    association :order, factory: :order
    postcode { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    block { '渋谷区道玄坂1-1-1' }
    building { '渋谷ビルディング' }
    phone_number { '09012345678' }
  end
end
