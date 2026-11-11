class AddReferencePhotoConstraintsToChallenges < ActiveRecord::Migration[7.2]
  def up
    change_column :challenges, :reference_photo_id, :bigint

    add_index :challenges, :reference_photo_id

    add_foreign_key :challenges, :photos,
                    column: :reference_photo_id
  end

  def down
    remove_foreign_key :challenges, column: :reference_photo_id

    remove_index :challenges, :reference_photo_id

    change_column :challenges, :reference_photo_id, :integer
  end
end