class AddDemoToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :demo, :boolean, default: false, null: false
  end
end
