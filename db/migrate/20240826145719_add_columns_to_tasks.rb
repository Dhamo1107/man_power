class AddColumnsToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :priority, :integer, default: 0, null: false
    add_column :tasks, :due_date, :datetime
    add_column :tasks, :completion_date, :datetime
    add_column :tasks, :comments, :text
  end
end
