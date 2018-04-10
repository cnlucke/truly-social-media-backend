class AddApiIdToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :api_id, :integer
  end
end
