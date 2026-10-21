class AddTitleToChallenges < ActiveRecord::Migration[7.2]
  def change
    add_column :challenges, :title, :string
  end
end
