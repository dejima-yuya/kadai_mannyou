require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト_アカウント名'
        fill_in 'user[email]', with: 'test@gmail.com'
        fill_in 'user[password]', with: 'testtest'
        fill_in 'user[password_confirmation]', with: 'testtest'
        click_on 'アカウントを作成'
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        visit new_task_path
        # ここにnew_task_pathにvisitする処理を書く
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task[title]', with: 'テスト_タイトル'
        fill_in 'task[content]', with: 'テスト_内容'
        fill_in 'task[end_date]', with: '002023-06-30'
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on '登録する'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'テスト_タイトル'
        expect(page).to have_content 'テスト_内容'
        expect(page).to have_content '2023-06-30'
        expect(page).to have_content '未着手'
        expect(page).to have_content '高'
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
      sleep(0.5)
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'テスト_タイトル1'
        expect(page).to have_content 'テスト_内容1'
        expect(page).to have_content '2023-06-30'
        expect(page).to have_content '未着手'
        expect(page).to have_content '低'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context '一覧画面に遷移した場合' do
      it 'タスクが作成日時の降順で並んでいる' do
        # タスク一覧ページに遷移
        visit tasks_path
        # タスクが作成日時の降順で表示されているかを確認する
        task_list = all('.task_list') 
        expect(task_list[0]).to have_content 'テスト_タイトル3'
        expect(task_list[1]).to have_content 'テスト_タイトル2'
        expect(task_list[2]).to have_content 'テスト_タイトル1'
      end
    end
    context '一覧画面内にある「終了期限」のリンクを押した場合' do
      it 'タスクが終了期限の降順で並んでいる' do
        # タスク一覧ページに遷移
        visit tasks_path
        # 「終了期限」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
        click_on '終了期限'
        sleep(0.5)
        # タスクが終了期限の降順で表示されているかを確認する
        task_list = all('.task_list') 
        expect(task_list[0]).to have_content 'テスト_タイトル1'
        expect(task_list[1]).to have_content 'テスト_タイトル2'
        expect(task_list[2]).to have_content 'テスト_タイトル3'
      end
    end
    context '一覧画面内にある「優先順位」のリンクを押した場合' do
      it 'タスクが優先順位の高い順で並んでいる' do
        # タスク一覧ページに遷移
        visit tasks_path
        # 「優先順位」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
        click_on '優先順位'
        sleep(0.5)
        # タスクが優先順位の高い順で表示されているかを確認する
        task_list = all('.task_list') 
        expect(task_list[0]).to have_content 'テスト_タイトル3'
        expect(task_list[1]).to have_content 'テスト_タイトル2'
        expect(task_list[2]).to have_content 'テスト_タイトル1'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        # テストで使用するためのタスクを作成し、変数taskに代入する
        user = FactoryBot.create(:user)
        task = FactoryBot.create(:task1, user: user)
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログイン'
        sleep(0.5)
        # 引数taskを持ちながらタスク一覧ページに遷移
        visit task_path(task)
        # visitした（遷移した）page（タスク一覧ページ）に文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'テスト_タイトル1'
        expect(page).to have_content 'テスト_内容1'
        expect(page).to have_content '2023-06-30'
        expect(page).to have_content '未着手'
        expect(page).to have_content '低'
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
      sleep(0.5)
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # タスク一覧ページに遷移
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する
        fill_in 'task[title]', with: 'テスト'
        # 検索ボタンを押す
        click_on '検索'
        sleep(0.5)
        # 検索されたタスクが表示されているかを確認する
        expect(page).to have_content 'テスト_タイトル1'
        expect(page).to have_content 'テスト_タイトル2'
        expect(page).to have_content 'テスト_タイトル3'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # タスク一覧ページに遷移
        visit tasks_path
        # プルダウンを選択する
        select '未着手', from: 'task[status]'
        # 検索ボタンを押す
        click_on '検索'
        sleep(0.5)
        # 検索されたタスクが表示されているかを確認する
        expect(page).to have_content 'テスト_タイトル1'
      end
    end
    context 'タイトルとステータスの両方で検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        # タスク一覧ページに遷移
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する
        # プルダウンを選択する
        fill_in 'task[title]', with: 'テスト'
        select '未着手', from: 'task[status]'
        # 検索ボタンを押す
        click_on '検索'
        sleep(0.5)
        # 検索されたタスクが表示されているかを確認する
        expect(page).to have_content 'テスト_タイトル1'
      end
    end
  end
end