FactoryBot.define do
  factory :item do
    association :user, factory: :user
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    category { Category.all.sample }
    condition { Condition.all.sample }
    shipping_payer { ShippingPayer.all.sample  }
    prefecture { Prefecture.all.sample }
    shipping_day { ShippingDay.all.sample }
    price { Faker::Commerce.price(range: 300..9_999_999) }
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end


