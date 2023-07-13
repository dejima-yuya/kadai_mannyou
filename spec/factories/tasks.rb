FactoryBot.define do
  factory :task1, class: Task do
    title { 'テスト_タイトル1' }
    content { 'テスト_内容1' }
    end_date { '2023-06-30' }
    status { '未着手' }
    priority { '低' }
  end

  factory :task2, class: Task do
    title { 'テスト_タイトル2' }
    content { 'テスト_内容2' }
    end_date { '2023-06-29' }
    status { '着手中' }
    priority { '中' }
  end

  factory :task3, class: Task do
    title { 'テスト_タイトル3' }
    content { 'テスト_内容3' }
    end_date { '2023-06-28' }
    status { '完了' }
    priority { '高' }
  end

  factory :user, class: User do
    id { 1 }
    name { 'user' }
    email { 'test@gmail.com' }
    password { 'testtest' }
    admin { false }
  end
end