# テーブル設計

## users table

| column             | type   | option                   |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false,unique: true |
| email              | string | null: false,unique: true |
| encrypted_password | string | null: false,unique: true |
| last_name          | string | null: false              |
| first_name         | string | null: false              |
| last_name_kana     | string | null: false              |
| first_name_kana    | string | null: false              |
| birthday           | date   | null: false              |

## Association

- has_many :items
- has_many :comments
- has_many :orders

## items table

| column         | type      | option      |
| -------------- | --------- | ----------- |
| user           | reference | null: false |
| name           | string    | null: false |
| description    | text      | null: false |
| category_id    | integer   | null: false |
| condition      | integer   | null: false |
| shipping_fee   | integer   | null: false |
| shipping_payer | integer   | null: false |
| shipping_from  | integer   | null: false |
| shipping_days  | integer   | null: false |
| price          | integer   | null: false |

### Association

- belongs_to :users
- has_one :order

## orders table

| column  | type      | option                        |
| ------- | --------- | ----------------------------- |
| item_id | reference | null: false,foreign_key: true |
| user    | reference | null: false,foreign_key: true |

### Association

- has_one :order_addresses
- belongs_to :user

## order_addressees table

| column        | type       | option                        |
| ------------- | ---------- | ----------------------------- |
| orders        | references | null: false,foreign_key: true |
| postcode      | string     | null: false                   |
| prefecture_id | integer    | null: false                   |
| city          | string     | null: false                   |
| block         | string     | null: false                   |
| building      | string     |                               |
| phone_number  | string     | null: false                   |

### Association

- belongs_to :order

## comments table

| column  | type      | option                        |
| ------- | --------- | ----------------------------- |
| content | text      | null: false                   |
| item    | reference | null: false,foreign_key: true |
| user    | reference | null: false,foreign_key: true |
| text    | text      | null: false                   |

### Association

- belongs_to :item
- belongs_to :user
