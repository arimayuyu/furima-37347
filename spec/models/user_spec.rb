require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できること' do 
    expect(@user).to be_valid
  end
   it 'ニックネームが空では登録できない' do
      @user.nickname = ''  # nicknameの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
   end
   it 'メールアドレスが空では登録できない' do
    @user.email = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Email can't be blank")
   end
   it '重複したemailが存在する場合登録できない' do
   @user.save
   another_user = FactoryBot.build(:user)
   another_user.email = @user.email
   another_user.valid?
   expect(another_user.errors.full_messages).to include('Email has already been taken')
  end
   it 'メールアドレスは、@を含む必要があること' do
    @user.email = 'fjghjbljftyu'
    @user.valid?
    expect(@user.errors.full_messages).to include('Email is invalid')
  end
   it 'パスワードが空では登録できない' do
    @user.password = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Password can't be blank")
   end
   it 'パスワードは、5文字以下では登録できない' do
    @user.password = '00000'
    @user.password_confirmation = '00000'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
   end
   it 'パスワードは、半角英数字混合での入力が必須であること' do
    @user.password = 'AAA'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
   end
   it 'パスワードとパスワード（確認）は、不一致では登録できない' do
    @user.password_confirmation = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
   end
   it 'お名前(全角)名字は、名字が必須である' do
    @user.first_name = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("First name can't be blank")
   end
   it 'お名前(全角)氏名は、名前が必須である' do
    @user.last_name = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name can't be blank")
   end
   it 'お名前カナ(全角)は、名字が必須であること' do
    @user.first_name_kana = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana can't be blank")
   end
   it 'お名前カナ(全角)は、名前が必須であること' do
    @user.last_name_kana = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana can't be blank")
   end
   it '生年月日が必須であること' do
    @user.birth_day = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Birth day can't be blank")
  end
   it 'お名前(全角)名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
    @user.first_name = 'test123'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
   end
   it 'お名前(全角)名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
    @user.last_name = 'test123'
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
   end
   it 'お名前カナ(全角)名字は、全角（カタカナ）での入力が必須であること' do
    @user.first_name_kana = 'test1234'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナのみで入力して下さい")
   end
   it 'お名前カナ(全角)名前は、全角（カタカナ）での入力が必須であること' do
    @user.last_name_kana = 'test1234'
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana 全角カタカナのみで入力して下さい")
   end
end