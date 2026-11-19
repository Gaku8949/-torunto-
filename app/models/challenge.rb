class Challenge < ApplicationRecord
  belongs_to :user
  belongs_to :reference_photo, class_name: "Photo"

  has_one_attached :image

  validates :image, presence: true

  has_one :shooting_setting, inverse_of: :challenge, dependent: :destroy

  has_many :challenge_techniques, dependent: :destroy
  has_many :techniques, through: :challenge_techniques

  has_many :challenge_favorites, dependent: :destroy
  has_many :challenge_comments, dependent: :destroy
  
  accepts_nested_attributes_for :shooting_setting

  def favorited_by?(user)
    challenge_favorites.exists?(user: user)
  end

  def demo_sample?
    demo_sample
  end
end
