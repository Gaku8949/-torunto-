class ShootingSetting < ApplicationRecord
  belongs_to :photo, inverse_of: :shooting_setting
end
