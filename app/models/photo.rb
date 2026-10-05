class Photo < ApplicationRecord
  belongs_to :user

  has_one_attached :image
  has_one :shooting_setting, inverse_of: :photo, dependent: :destroy

  has_many :photo_techniques, dependent: :destroy
  has_many :techniques, through: :photo_techniques

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :challenges, foreign_key: :reference_photo_id, dependent: :destroy

  accepts_nested_attributes_for :shooting_setting, update_only: true
end
