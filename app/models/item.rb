class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  

  validates :image, :name, :description, :detail_id, :regarding_delivery_id, :selling_price_id,:category_id, :prefecture_id,:worth, presence: true
  validates :category_id, :detail_id, :prefecture_id, :regarding_delivery_id, :selling_price_id, numericality: { other_than: 0 }
  validates_inclusion_of :worth, in: 300..9_999_999, message: 'This site is only for under 300 and over 9,999,999'
  validates :worth, numericality: { with: /\A[0-9]+\z/ }
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :selling_price
  belongs_to :category
  belongs_to :detail
  belongs_to :prefecture
  belongs_to :regarding_delivery
  
  
end
