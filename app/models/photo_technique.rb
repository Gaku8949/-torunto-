class PhotoTechnique < ApplicationRecord
  belongs_to :photo
  belongs_to :technique
end