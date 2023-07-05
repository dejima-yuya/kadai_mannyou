FactoryBot.define do
  factory :task do
    title { 'テスト_タイトル' }
    content { 'テスト_内容' }
    end_date { '2023-06-30' }
  end
end