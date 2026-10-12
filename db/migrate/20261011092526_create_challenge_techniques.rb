class CreateChallengeTechniques < ActiveRecord::Migration[7.2]
  def change
    create_table :challenge_techniques do |t|
      t.references :challenge, null: false, foreign_key: true
      t.references :technique, null: false, foreign_key: true

      t.timestamps
    end
  end
end
