class CreateActs < ActiveRecord::Migration[5.1]
  def change
    create_table :acts do |t|
      t.integer :actor_id
      t.integer :activity_type
      t.integer :entity_id
      t.string :entity_type
      t.timestamps
    end
  end
end
