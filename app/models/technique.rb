class Technique < ApplicationRecord
  has_many :photo_techniques, dependent: :destroy
  has_many :photos, through: :photo_techniques
end