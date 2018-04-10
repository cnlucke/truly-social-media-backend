class AddTimestampToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :timestamp, :string
  end
end
