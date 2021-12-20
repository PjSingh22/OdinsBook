class User < ApplicationRecord
  after_commit :add_default_avatar, on: [:create, :update]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :friend_requests, dependent: :destroy, foreign_key: :user_id
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :user_posts
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '200x200!').processed
    else
      '/default_profile.jpg'
    end
  end

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open('app/assets/images/default_profile.jpg'), filename: 'default_profile.jpg', content_type: 'image/jpg')
    end
  end
end
