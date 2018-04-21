class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :api_id
      t.string :title
      t.string :date
      t.string :poster_url
      t.string :backdrop_url
      t.text :overview
      t.string :media_type
      t.string :genres
      t.float :rating, default: 0.0
      t.timestamps
    end
  end
end
