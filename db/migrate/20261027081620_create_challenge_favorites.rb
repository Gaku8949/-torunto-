class CreateChallengeFavorites < ActiveRecord::Migration[7.2]
  def change
    create_table :challenge_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
