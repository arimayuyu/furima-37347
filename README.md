# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| nickname           | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| birth_day          | date    | null: false               |

### Association

- has_many    :items
- has_many    :orders

## items テーブル

| Column                | Type       | Options           |
  | --------------------- | ---------- | ----------------- |
| name                  | string     | null: false       |
| description           | text       | null: false       |
| detail_id             | integer    | null: false       |
| regarding_delivery_id | integer    | null: false       |
| selling_price_id      | integer    | null: false       |
| category_id           | integer    | null: false       |
| prefecture_id         | integer    | null: false       |
| worth                 | integer    | null: false       |
| user                  | references | foreign_key :true |

### Association

- has_one    :order
- belongs_to :user

## addresses テーブル

| Column        | Type       | Options          |
| ------------- | ---------- | ---------------- |
| postal_code   | string     | null: false      |
| prefecture_id | integer    | null: false      |
| municipality  | string     | null: false      |
| address       | string     | null: false      |
| building_name | string     |                  |
| phone_number  | string     | null: false      |
| order         | references | foreign_key:true |

### Association

- belongs_to :order

## orders テーブル
| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| item    | references | foreign_key :true |
| user    | references | foreign_key :true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :address