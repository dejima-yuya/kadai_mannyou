require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト', end_date: '2023-06-30', status: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの内容が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '', end_date: '2023-06-30', status: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの終了期限が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '失敗テスト', end_date: '', status: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのステータスが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '失敗テスト', end_date: '2023-06-30', status: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細と終了期限とステータスに内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト', end_date: '2023-06-30', status: '成功テスト')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:first_task) { FactoryBot.create(:task, title: 'テスト_タイトル1', content: 'テスト_内容1', end_date: '2023-06-30', status: '未着手') }
    let!(:second_task) { FactoryBot.create(:task, title: 'テスト_タイトル2', content: 'テスト_内容2', end_date: '2023-06-29', status: '着手中') }
    let!(:third_task) { FactoryBot.create(:task, title: 'test_title', content: 'test_content', end_date: '2023-06-28', status: '完了') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('テスト')).to include(first_task)
        expect(Task.search_title('テスト')).to include(second_task)
        expect(Task.search_title('テスト')).not_to include(third_task)
        expect(Task.search_title('テスト').count).to eq 2
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('未着手')).to include(first_task)
        expect(Task.search_status('未着手')).not_to include(second_task)
        expect(Task.search_status('未着手')).not_to include(third_task)
        expect(Task.search_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title_status('テスト','未着手')).to include(first_task)
        expect(Task.search_title_status('テスト','未着手')).not_to include(second_task)
        expect(Task.search_title_status('テスト','未着手')).not_to include(third_task)
        expect(Task.search_title_status('テスト','未着手').count).to eq 1
      end
    end
  end
end
