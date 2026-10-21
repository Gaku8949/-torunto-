class ShootingSetting < ApplicationRecord
  belongs_to :photo, inverse_of: :shooting_setting, optional: true
  belongs_to :challenge, optional: true
end
