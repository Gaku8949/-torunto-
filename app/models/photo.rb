class Photo < ApplicationRecord
  belongs_to :user

  has_one_attached :image
  has_one :shooting_setting

  accepts_nested_attributes_for :shooting_setting
end
