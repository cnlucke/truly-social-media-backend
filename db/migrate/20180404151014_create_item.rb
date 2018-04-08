class CreateItem < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :api_id
      t.string :title
      t.string :date
      t.string :poster_url
      t.string :backdrop_url
      t.text :overview
      t.string :item_type
      t.string :genres

      t.timestamps
    end
  end
end
