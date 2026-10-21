class AllowNullPhotoIdInShootingSettings < ActiveRecord::Migration[7.2]
  def change
    change_column_null :shooting_settings, :photo_id, true
  end
end
