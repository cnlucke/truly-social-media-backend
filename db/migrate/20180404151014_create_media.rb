class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.string :api_id
      t.string :title
      t.string :release_date
      t.string :poster_url
      t.string :backdrop_url
      t.text :overview
      t.string :media_type
      t.string :genres

      t.timestamps
    end
  end
end
