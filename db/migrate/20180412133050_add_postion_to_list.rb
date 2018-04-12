class AddPostionToList < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :position, :integer, default: 0
  end
end
