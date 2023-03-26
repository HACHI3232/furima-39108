FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    nickname { Faker::Internet.username }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    first_name { person.first.kanji }
    last_name { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
  end
end

