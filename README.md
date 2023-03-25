# テーブル設計

## users table

| column             | type   | option                   |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false,unique: true |
| encrypted_password | string | null: false              |
| last_name          | string | null: false              |
| first_name         | string | null: false              |
| last_name_kana     | string | null: false              |
| first_name_kana    | string | null: false              |
| birthday           | date   | null: false              |

## Association

- has_many :items
- has_many :orders

## items table

| column            | type       | option                        |
| ----------------- | ---------- | ----------------------------- |
| user              | references | null: false,foreign_key: true |
| name              | string     | null: false                   |
| description       | text       | null: false                   |
| category_id       | integer    | null: false                   |
| condition_id      | integer    | null: false                   |
| shipping_payer_id | integer    | null: false                   |
| prefecture_id     | integer    | null: false                   |
| shipping_day_id   | integer    | null: false                   |
| price             | integer    | null: false                   |

### Association

- belongs_to :user
- has_one :order

## orders table

| column | type       | option                        |
| ------ | ---------- | ----------------------------- |
| item   | references | null: false,foreign_key: true |
| user   | references | null: false,foreign_key: true |

### Association

- has_one :order_address
- belongs_to :user
- belongs to :item

## order_addressees table

| column        | type       | option                        |
| ------------- | ---------- | ----------------------------- |
| order         | references | null: false,foreign_key: true |
| postcode      | string     | null: false                   |
| prefecture_id | integer    | null: false                   |
| city          | string     | null: false                   |
| block         | string     | null: false                   |
| building      | string     |                               |
| phone_number  | string     | null: false                   |

### Association

- belongs_to :order

## comments table
