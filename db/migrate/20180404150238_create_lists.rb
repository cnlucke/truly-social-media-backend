class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :list_type
      t.timestamps
    end
  end
end
