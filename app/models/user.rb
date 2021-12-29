class User < ApplicationRecord
  after_commit :add_default_avatar, on: [:create, :update]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

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

  def self.from_omniauth(auth)
    name = auth.info.name
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, name: name, username: auth.info.name, email: auth.info.email,password: Devise.friendly_token[0, 20])
      user
  end

  def avatar_thumbnail
    # error handle
    begin
      if avatar.attached?
        avatar.variant(resize: '300x300!').processed
      else
        '/default_profile.jpg'
      end 
    rescue => exception
      exception.message
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
