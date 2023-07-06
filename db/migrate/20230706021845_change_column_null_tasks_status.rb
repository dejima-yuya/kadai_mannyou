class ChangeColumnNullTasksStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :status, :string, null: false
  end
end
