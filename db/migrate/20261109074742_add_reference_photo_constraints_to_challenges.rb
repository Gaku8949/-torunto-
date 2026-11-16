class AddReferencePhotoConstraintsToChallenges < ActiveRecord::Migration[7.2]
  def up
    change_column :challenges, :reference_photo_id, :bigint

    unless index_exists?(:challenges, :reference_photo_id)
      add_index :challenges, :reference_photo_id
    end

    unless foreign_key_exists?(:challenges, :photos, column: :reference_photo_id)
      add_foreign_key :challenges, :photos,
                      column: :reference_photo_id
    end
  end

  def down
    if foreign_key_exists?(:challenges, :photos, column: :reference_photo_id)
      remove_foreign_key :challenges, column: :reference_photo_id
    end

    if index_exists?(:challenges, :reference_photo_id)
      remove_index :challenges, :reference_photo_id
    end

    change_column :challenges, :reference_photo_id, :integer
  end
end