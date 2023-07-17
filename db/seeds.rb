User.create!(name: 'test', email: 'test@gmail.com', password: 'testtest', admin: true)

10.times do |i|
  Label.create!(title: "ラベルテスト#{i + 1}")
end