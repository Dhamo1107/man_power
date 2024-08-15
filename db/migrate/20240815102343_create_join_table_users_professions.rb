class CreateJoinTableUsersProfessions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :professions do |t|
      t.index [:user_id, :profession_id], unique: true
      t.index [:profession_id, :user_id]
    end
  end
end
