require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  describe '新規作成機能' do
    before do
      FactoryBot.create(:label1)
      FactoryBot.create(:label2)
      FactoryBot.create(:label3)
    end
    context 'タスクの新規作成時にラベルも登録した場合' do
      it '作成したタスクの情報内にラベルも表示される' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト_アカウント名'
        fill_in 'user[email]', with: 'test@gmail.com'
        fill_in 'user[password]', with: 'testtest'
        fill_in 'user[password_confirmation]', with: 'testtest'
        click_on 'アカウントを作成'
        sleep(0.2)
        visit new_task_path
        fill_in 'task[title]', with: 'テスト_タイトル'
        fill_in 'task[content]', with: 'テスト_内容'
        fill_in 'task[end_date]', with: '002023-06-30'
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        check "ラベルテスト1"
        click_on '登録する'
        sleep(0.2)
        expect(page).to have_content 'テスト_タイトル'
        expect(page).to have_content 'テスト_内容'
        expect(page).to have_content '2023-06-30'
        expect(page).to have_content '未着手'
        expect(page).to have_content '高'
        expect(page).to have_content 'ラベルテスト1'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      user = FactoryBot.create(:user)
      FactoryBot.create(:task1, user: user)
      FactoryBot.create(:task2, user: user)
      FactoryBot.create(:task3, user: user)
      visit new_session_path
      fill_in 'session[email]', with: 'test@gmail.com'
      fill_in 'session[password]', with: 'testtest'
      click_on 'ログイン'
      sleep(0.2)
    end
    context '一覧画面に遷移した場合' do
      it 'タスクのラベルも表示される' do
        visit tasks_path
        expect(page).to have_content 'ラベルテスト1'
        expect(page).to have_content 'ラベルテスト2'
        expect(page).to have_content 'ラベルテスト3'
      end
    end
  end

  describe '詳細表示機能' do
    before do
      user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task1, user: user)
      visit new_session_path
      fill_in 'session[email]', with: 'test@gmail.com'
      fill_in 'session[password]', with: 'testtest'
      click_on 'ログイン'
      sleep(0.2)
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクのラベルも表示される' do
        visit task_path(@task)
        expect(page).to have_content 'テスト_タイトル1'
        expect(page).to have_content 'テスト_内容1'
        expect(page).to have_content '2023-06-30'
        expect(page).to have_content '未着手'
        expect(page).to have_content '低'
        expect(page).to have_content 'ラベルテスト1'
      end
    end
  end

  describe '検索機能' do
    before do
      user = FactoryBot.create(:user)
      FactoryBot.create(:task1, user: user)
      FactoryBot.create(:task2, user: user)
      FactoryBot.create(:task3, user: user)
      visit new_session_path
      fill_in 'session[email]', with: 'test@gmail.com'
      fill_in 'session[password]', with: 'testtest'
      click_on 'ログイン'
      sleep(0.2)
    end
    context 'ラベルで検索をした場合' do
      it "ラベルに一致したタスクが絞り込まれる" do
        visit tasks_path
        select 'ラベルテスト1', from: 'task[label_id]'
        click_on '検索'
        sleep(0.2)
        expect(page).to have_content 'ラベルテスト1'
      end
    end
  end
end