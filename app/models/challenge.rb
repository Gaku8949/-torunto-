class Challenge < ApplicationRecord
  belongs_to :user
  belongs_to :reference_photo, class_name: "Photo"

  has_one_attached :image

  has_one :shooting_setting, inverse_of: :challenge, dependent: :destroy

  accepts_nested_attributes_for :shooting_setting
  
  has_many :challenge_techniques, dependent: :destroy
  has_many :techniques, through: :challenge_techniques
end
