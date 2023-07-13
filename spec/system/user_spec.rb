require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :system do
  describe 'ユーザー作成機能' do
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
        user = FactoryBot.build(:user)
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(current_path).to eq new_session_path
      end
    end
  end
end