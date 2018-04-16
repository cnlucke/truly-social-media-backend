class ChangeItemRatingToDecimal < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :rating, :decimal
  end
end
