class CreateTechniques < ActiveRecord::Migration[7.2]
  def change
    create_table :techniques do |t|
      t.string :name
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
