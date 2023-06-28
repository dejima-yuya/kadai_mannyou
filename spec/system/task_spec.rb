require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        visit new_task_path
        # ここにnew_task_pathにvisitする処理を書く
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task[title]', with: 'テスト'
        fill_in 'task[content]', with: 'テスト内容'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on 'Create Task'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content('テスト内容')
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context '一覧画面に遷移した場合' do
      it 'タスクが作成日時の降順で並んでいる' do
        # テストで使用するためのタスクを作成
        FactoryBot.create(:task, title: 'テスト1', content: 'テスト内容1')
        FactoryBot.create(:task, title: 'テスト2', content: 'テスト内容2')
        FactoryBot.create(:task, title: 'テスト3', content: 'テスト内容3')
        # タスク一覧ページに遷移
        visit tasks_path
        # タスクが作成日時の降順で表示されているかを確認する
        task_list = all('.task_list') 
        expect(task_list[0]).to have_content 'テスト3'
        expect(task_list[1]).to have_content 'テスト2'
        expect(task_list[2]).to have_content 'テスト1'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          task = FactoryBot.create(:task, title: 'テスト', content: 'テスト内容')
          visit task_path(task)
          expect(page).to have_content 'テスト'
          expect(page).to have_content 'テスト内容'
        end
     end
  end
end