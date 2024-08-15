class CreateProfessions < ActiveRecord::Migration[7.0]
  def change
    create_table :professions do |t|
      t.string :name, null: false, unique: true

      t.timestamps
    end

    add_index :professions, :name, unique: true
  end
end
