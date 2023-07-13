FactoryBot.define do
  factory :user do
    name { "一般ユーザ" }
    email { "test@gmail.com" }
    password { "testtest" }
    admin { false }
  end
end
