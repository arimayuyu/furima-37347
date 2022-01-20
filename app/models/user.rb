class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :items
         #has_many :orders
  
         with_options presence: true do
          validates :nickname
          validates :birth_day
          PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
          validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
          validates :password_confirmation
          validates :first_name,:last_name, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: '全角文字を使用してください' }
          validates :first_name_kana, :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "全角カタカナのみで入力して下さい"}
         end
  end