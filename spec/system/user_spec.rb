require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録機能' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト_名前'
        fill_in 'user[email]', with: 'test@gmail.com'
        fill_in 'user[password]', with: 'testtest'
        fill_in 'user[password_confirmation]', with: 'testtest'
        click_on 'アカウントを作成'
        expect(page).to have_content 'テスト_名前'
        expect(page).to have_content 'test@gmail.com'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能' do
    before do
      FactoryBot.create(:user1)
      FactoryBot.create(:user2)
    end
    context 'ログインした場合' do
      it 'ユーザーの詳細画面が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        expect(page).to have_content '一般ユーザ'
        expect(page).to have_content 'test@gmail.com'
        expect(current_path).to eq user_path(1)
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶと' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        visit user_path(2)
        expect(current_path).to eq tasks_path
      end
    end
    context 'ログアウトした場合' do
      it 'ログイン画面が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq new_session_path
      end
    end
  end
end