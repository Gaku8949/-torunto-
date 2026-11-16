class SetDefaultAndNotNullForDemoSample < ActiveRecord::Migration[7.2]
  def change
    change_column_default :photos, :demo_sample, from: nil, to: false
    change_column_null :photos, :demo_sample, false, false
  end
end