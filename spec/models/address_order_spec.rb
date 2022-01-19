require 'rails_helper'
RSpec.describe :address_order, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @item = FactoryBot.build(:address_order, user_id: user.id, item_id: item.id)
    sleep (0.5)
  end

  describe '商品購入機能' do
    context '商品が購入できる時' do 
      it '全て正常' do
        expect(@item).to be_valid
      end
      it '建物名がなくても登録が出来る時' do
        @item.building_name = nil
        expect(@item).to be_valid
      end
    end
    
    context '商品が購入できない時' do
      it 'addressが必須であること' do
        @item.address = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Address can't be blank")
      end
      it 'municipalityが必須であること' do
        @item.municipality = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'prefecture_idが必須であること' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが０以外でないと登録出来ない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
      end    
      it 'addressが必須であること' do
        @item.address = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Address can't be blank")
      end    
      it '電話番号にはハイフンがあったら登録出来ないこと' do
        @item.phone_number = '123-4567-9089'
        @item.valid?
        expect(@item.errors.full_messages).to include("Phone number is invalid")
      end    
      it '郵便番号にはハイフンが必要であること' do
        @item.postal_code = '1230567'
        @item.valid?
      
        expect(@item.errors.full_messages).to include("Postal code is invalid")
      end    
      it '電話番号は11桁以内であること' do
        @item.phone_number = '123056788888888'
        @item.valid?
        expect(@item.errors.full_messages).to include("Phone number is invalid")
      end    
      it '購入者が空だと購入できない' do
        @item.user_id = nil        
        @item.valid?
        expect(@item.errors.full_messages).to include("User can't be blank")
      end
      it '商品が空だと購入出来ない' do
        @item.item_id = nil        
        @item.valid?
        expect(@item.errors.full_messages).to include("Item can't be blank")
      end    
      it 'phone_numberがないと登録出来ない' do
        @item.phone_number = nil        
        @item.valid?
        expect(@item.errors.full_messages).to include("Phone number can't be blank")
      end 
      it 'postal_codeがないと登録出来ない' do
        @item.postal_code = nil        
        @item.valid?
        expect(@item.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'PAYJP_PUBLIC_KEYがないと登録出来ない' do
        @item.token = nil        
        @item.valid?
        expect(@item.errors.full_messages).to include("Token can't be blank")
      end         
    end
  end
end
