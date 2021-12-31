class UserPost < ApplicationRecord
  belongs_to :user

  validates :message, length: { maximum: 140 }
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
end
