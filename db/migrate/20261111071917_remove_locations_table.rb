class RemoveLocationsTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :locations do |t|
      t.string :name
      t.timestamps
    end
  end
end