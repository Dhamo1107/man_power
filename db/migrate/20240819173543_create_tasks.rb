class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :status, null: false, default: 0
      t.references :created_by_user, null: false, foreign_key: { to_table: :users }
      t.references :assigned_to_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
