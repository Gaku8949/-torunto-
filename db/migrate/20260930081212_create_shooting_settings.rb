class CreateShootingSettings < ActiveRecord::Migration[7.2]
  def change
    create_table :shooting_settings do |t|
      t.references :photo, null: false, foreign_key: true
      t.string :aperture
      t.integer :iso
      t.string :shutter_speed
      t.string :focal_length

      t.timestamps
    end
  end
end
