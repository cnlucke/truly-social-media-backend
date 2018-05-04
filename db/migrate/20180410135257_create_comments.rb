class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :api_id
      t.integer :parent_id
      t.text :content
      t.string :username
      t.timestamps
    end
  end
end
