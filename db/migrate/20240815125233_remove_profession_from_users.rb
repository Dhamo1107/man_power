class RemoveProfessionFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :profession, :string
  end
end
