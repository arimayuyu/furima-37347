class AddressOrder
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :municipality, :building_name, :address, :phone_number, :token

  with_options presence: true do
    validates :address, :prefecture_id, :municipality, :user_id, :item_id
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/}
    validates :phone_number, format: { with: /\A\d{10,11}\z/}
    validates :token
  end
    validates :prefecture_id, numericality: { other_than: 0 }

  def save
    
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end