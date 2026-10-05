class Challenge < ApplicationRecord
  belongs_to :user
  belongs_to :reference_photo, class_name: "Photo"

  has_one_attached :image
end
