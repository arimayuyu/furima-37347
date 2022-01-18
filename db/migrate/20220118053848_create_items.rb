class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name,                  null: false
      t.text       :description,           null: false
      t.integer    :detail_id,             null: false
      t.integer    :regarding_delivery_id, null: false
      t.integer    :selling_price_id,      null: false
      t.integer    :category_id,           null: false
      t.integer    :prefecture_id,         null: false
      t.integer    :worth,                 null: false
      t.references :user,                  null: false, foreign_key: true
      t.timestamps
    end
  end
end