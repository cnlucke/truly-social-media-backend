class ChangeRatingColumnToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :rating, :float
  end
end
