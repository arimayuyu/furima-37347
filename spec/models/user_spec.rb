require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録情報' do
    it "nickname、email、パスワード、姓（カナ）、名（カナ）、誕生日がある場合、有効である" do
      ＠user = FactoryBot.build(:user)
      expect(＠user).to be_valid
    end
    before do
      @user = FactoryBot.build(:user)
    end
  # pending "add some examples to (or delete) #{__FILE__}"
    it 'ニックネームは空だと保存できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'アドレスは空だと保存できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it '同じアドレスは登録できないこと' do
      @user = FactoryBot.create(:user, email: 'aaaaaa@sample.com')
      @user = FactoryBot.build(:user, email: 'aaaaaa@sample.com')
      @user.valid?
      expect(@user.errors[:email]).to include("has already been taken")
    end
    it 'アドレスは@を含むこと' do
      @user.email = 'abccdsample.com'
      @user.valid?
      expect(@user.errors[:email]).to include("is invalid")
    end
    it 'パスワードは空では保存できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは６文字以上であること' do
      @user.password = 'abcde'
      @user.valid?
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
    it 'パスワードは半角英数字混合であること' do
      @user.password = 'ああ１２３'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'パスワードは数字のみでは登録できないこと' do
    @user.password = '123456'
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードは確認のため2回入力すること' do
      @user = FactoryBot.build(:user, password_confirmation: '')
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it '名字は空だと保存できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors[:first_name]).to include("can't be blank")
    end
    it '名前は空だと保存できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors[:last_name]).to include("can't be blank")
    end
    it 'ユーザー本名は全角（漢字・ひらがな・カタカナ）で入力させること' do
      @user.first_name = 'abc123'
      @user.valid?
      expect(@user.errors[:first_name]).to include("is invalid. Input full-width characters.")
    end
    it 'ユーザー本名のフリガナが、名字と名前でそれぞれ必須であること' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors[:first_name]).to include("can't be blank", "is invalid. Input full-width characters.")
    end
    it 'ユーザー本名のフリガナが、名字と名前でそれぞれ必須であること' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors[:last_name]).to include("can't be blank", "is invalid. Input full-width characters.")
    end
    it 'ユーザー本名のフリガナは全角（カタカナ）で入力させること' do
      @user.first_name_kana = 'ヵﾅ'
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include("is invalid. Input full-width katakana characters.")
    end
    it 'ユーザー本名のフリガナは全角（カタカナ）で入力させること' do
      @user.last_name_kana = 'ｶﾅ'
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include("is invalid. Input full-width katakana characters.")
    end
    it '生年月日が必須であること' do
      @user.birth_day = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end
  end
end