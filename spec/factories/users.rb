FactoryBot.define do
  factory :user1, class: User do
    id { 1 }
    name { '一般ユーザ' }
    email { 'test@gmail.com' }
    password { 'testtest' }
    admin { false }
  end

  factory :user2, class: User do
    id { 2 }
    name { "管理ユーザ" }
    email { "admin@gmail.com" }
    password { "testtest" }
    admin { true }
  end
end
