class AddDemoSampleToPhotos < ActiveRecord::Migration[7.2]
  def change
    add_column :photos, :demo_sample, :boolean, default: false, null: false
  end
end
