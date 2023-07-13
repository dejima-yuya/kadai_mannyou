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
        sleep(0.5)
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

  describe '管理者機能' do
    before do
      FactoryBot.create(:user1)
      FactoryBot.create(:user2)
    end
    context '管理ユーザーが管理画面へアクセスした場合' do
      it '管理画面が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        sleep(0.5)
        visit admin_users_path
        expect(current_path).to eq admin_users_path
        expect(page).to have_content 'ユーザー一覧'
      end
    end
    context '一般ユーザーが管理画面へアクセスした場合' do
      it '管理画面が表示されず、「管理者以外はアクセスできません」と表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        sleep(0.5)
        visit admin_users_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
    context '管理ユーザーがユーザーを新規登録しようとした場合' do
      it 'ユーザーが新規登録される' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        sleep(0.5)
        visit new_admin_user_path
        fill_in 'name', with: '作成されたユーザー'
        fill_in 'email', with: 'created_user@gmail.com'
        fill_in 'password', with: 'testtest'
        fill_in 'password_confirmation', with: 'testtest'
        click_on 'ユーザーを作成'
        expect(page).to have_content 'ユーザーを作成しました'
      end
    end
    context '管理ユーザーがユーザーの詳細画面にアクセスしようとすると' do
      it 'ユーザーの詳細画面が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        sleep(0.5)
        visit admin_user_path(1)
        expect(current_path).to eq admin_user_path(1)
        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content '一般ユーザ'
      end
    end
    context '管理ユーザーがユーザーの編集画面でユーザーを編集しようとすると' do
      it 'ユーザーが編集される' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        visit edit_admin_user_path(1)
        fill_in 'name', with: '編集されたユーザー'
        fill_in 'email', with: 'edited_user@gmail.com'
        fill_in 'password', with: 'testtest'
        fill_in 'password_confirmation', with: 'testtest'
        click_on 'ユーザーを編集'
        expect(page).to have_content 'ユーザーを編集しました'
      end
    end
    context '管理ユーザーがユーザー画面でユーザーを削除しようとすると' do
      it 'ユーザーが削除される' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        sleep(0.5)
        visit admin_users_path
        click_on 'ユーザーを削除する', match: :first 
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
  end
end