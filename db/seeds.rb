user = User.create!(name: 'test', email: 'test@gmail.com', password: 'testtest', admin: true)
user01 = User.create!(name: 'test01', email: 'test01@gmail.com', password: 'testtest', admin: true)
user02 = User.create!(name: 'test02', email: 'test02@gmail.com', password: 'testtest', admin: true)
user03 = User.create!(name: 'test03', email: 'test03@gmail.com', password: 'testtest', admin: true)
user04 = User.create!(name: 'test04', email: 'test04@gmail.com', password: 'testtest', admin: true)
user05 = User.create!(name: 'test05', email: 'test05@gmail.com', password: 'testtest', admin: true)
user06 = User.create!(name: 'test06', email: 'test06@gmail.com', password: 'testtest', admin: false)
user07 = User.create!(name: 'test07', email: 'test07@gmail.com', password: 'testtest', admin: false)
user08 = User.create!(name: 'test08', email: 'test08@gmail.com', password: 'testtest', admin: false)
user09 = User.create!(name: 'test09', email: 'test09@gmail.com', password: 'testtest', admin: false)
user010 = User.create!(name: 'test10', email: 'test10@gmail.com', password: 'testtest', admin: false)

task = user.tasks.create!(
  title: 'テスト_タイトル',
  content: 'テスト_内容',
  end_date: '2023-06-30',
  status: '未着手',
  priority: '低'
)

task01 = user01.tasks.create!(
  title: 'テスト_タイトル01',
  content: 'テスト_内容01',
  end_date: '2023-07-01',
  status: '着手中',
  priority: '中'
)

task02 = user01.tasks.create!(
  title: 'テスト_タイトル02',
  content: 'テスト_内容02',
  end_date: '2023-07-02',
  status: '完了',
  priority: '高'
)

task03 = user01.tasks.create!(
  title: 'テスト_タイトル03',
  content: 'テスト_内容03',
  end_date: '2023-07-03',
  status: '未着手',
  priority: '高'
)

task04 = user01.tasks.create!(
  title: 'テスト_タイトル04',
  content: 'テスト_内容04',
  end_date: '2023-07-04',
  status: '未着手',
  priority: '中'
)

task05 = user02.tasks.create!(
  title: 'テスト_タイトル05',
  content: 'テスト_内容05',
  end_date: '2023-07-05',
  status: '着手中',
  priority: '高'
)

task06 = user02.tasks.create!(
  title: 'テスト_タイトル06',
  content: 'テスト_内容06',
  end_date: '2023-07-06',
  status: '着手中',
  priority: '低'
)

task07 = user02.tasks.create!(
  title: 'テスト_タイトル07',
  content: 'テスト_内容07',
  end_date: '2023-07-07',
  status: '完了',
  priority: '中'
)

task08 = user03.tasks.create!(
  title: 'テスト_タイトル08',
  content: 'テスト_内容08',
  end_date: '2023-07-08',
  status: '完了',
  priority: '低'
)

task09 = user03.tasks.create!(
  title: 'テスト_タイトル09',
  content: 'テスト_内容09',
  end_date: '2023-07-09',
  status: '未着手',
  priority: '低'
)

task10 = user03.tasks.create!(
  title: 'テスト_タイトル10',
  content: 'テスト_内容10',
  end_date: '2023-07-10',
  status: '着手中',
  priority: '中'
)

task.labels.create!(title: "ラベルテスト")
task01.labels.create!(title: "ラベルテスト1")
task02.labels.create!(title: "ラベルテスト2")
task03.labels.create!(title: "ラベルテスト3")
task04.labels.create!(title: "ラベルテスト4")
task05.labels.create!(title: "ラベルテスト5")
task06.labels.create!(title: "ラベルテスト6")
task07.labels.create!(title: "ラベルテスト7")
task08.labels.create!(title: "ラベルテスト8")
task09.labels.create!(title: "ラベルテスト9")
task10.labels.create!(title: "ラベルテスト10")
