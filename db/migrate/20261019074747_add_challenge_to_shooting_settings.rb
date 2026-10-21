class AddChallengeToShootingSettings < ActiveRecord::Migration[7.2]
  def change
    add_reference :shooting_settings, :challenge, null: true, foreign_key: true
  end
end
