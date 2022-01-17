FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 {Faker::Internet.free_email}
    password              { 'a0000000' }
    password_confirmation { password }
    first_name            { '試験' }
    last_name             { '太郎' }
    first_name_kana       { 'シケン' }
    last_name_kana        { 'タロウ' }
    birth_day             { '1950-01-01' }
  end
end