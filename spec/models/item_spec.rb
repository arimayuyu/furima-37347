require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    it '全て正常' do
      expect(@item).to be_valid
    end

    it 'imageが必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が必須であること' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明が必須であること' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it 'カテゴリーのidが０以外であること' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 0')
    end

    it '商品の状態のidが０以外であること' do
      @item.detail_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Detail must be other than 0')
    end

    it '配送料の負担のidが０以外であること' do
      @item.selling_price_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Selling price must be other than 0')
    end

    it '発送元の地域のidが０以外であること' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
    end

    it '発送までの日数のidが０以外であること' do
      @item.regarding_delivery_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Regarding delivery must be other than 0')
    end

    it '価格についての情報が必須であること' do
      @item.worth = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Worth can't be blank")
    end

    it '価格の範囲が、¥299円以下では出品できないこと' do
      @item.worth = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Worth This site is only for under 300 and over 9,999,999')
    end

    it '価格の範囲が、¥100,000,00以上では出品できないこと' do
      @item.worth = 10, 0o00, 0o00
      @item.valid?
      expect(@item.errors.full_messages).to include('Worth This site is only for under 300 and over 9,999,999')
    end

    it '販売価格は全角数字では登録できないこと' do
      @item.worth = '１２３４'
      @item.valid?
      expect(@item.errors.full_messages).to include('Worth is not a number')
    end

    it '販売価格は半角英数混合では登録できないこと' do
      @item.worth = '3rt'
      @item.valid?
      expect(@item.errors.full_messages).to include('Worth is not a number')
    end

    it '販売価格は半角英語だけでは登録できないこと' do
      @item.worth = 'wer'
      @item.valid?
      expect(@item.errors.full_messages).to include('Worth is not a number')
    end
  end
end