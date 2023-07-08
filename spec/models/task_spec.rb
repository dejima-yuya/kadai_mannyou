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
end
