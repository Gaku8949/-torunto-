class CreatePhotoTechniques < ActiveRecord::Migration[7.2]
  def change
    create_table :photo_techniques do |t|
      t.references :photo, null: false, foreign_key: true
      t.references :technique, null: false, foreign_key: true

      t.timestamps
    end

    add_index :photo_techniques, [:photo_id, :technique_id], unique: true
  end
end
