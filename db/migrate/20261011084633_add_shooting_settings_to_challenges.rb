class AddShootingSettingsToChallenges < ActiveRecord::Migration[7.2]
  def change
    add_column :challenges, :location, :string
    add_column :challenges, :aperture, :string
    add_column :challenges, :iso, :integer
    add_column :challenges, :shutter_speed, :string
    add_column :challenges, :focal_length, :string
  end
end
