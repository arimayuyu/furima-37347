FactoryBot.define do
    factory :item do
      name { 'みかん' }
      description                       { 'うまい' }
      detail_id                         { 2 }
      regarding_delivery_id             { 2 }
      selling_price_id                  { 2 }
      category_id                       { 2 }
      prefecture_id                     { 2 }
      worth                             { 300 }
      association :user
  
      after(:build) do |item|
        item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
      
      end
    end
end