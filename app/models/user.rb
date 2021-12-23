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
      avatar.variant(resize: '300x300!').processed
    else
      '/default_profile.jpg'
    end
  end

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end

  # def no_relations # check if user is not friends with other user or have sent them a request.
  #   join_statement = <<-SQL
  #     LEFT OUTER JOIN friendships
  #       ON (friendships.user_id = users.id OR friendships.friend_id = users.id)
  #       AND (friendships.user_id = #{id} OR friendships.friend_id = #{id})
  #     LEFT OUTER JOIN friend_requests
  #       ON (friend_requests.user_id = users.id OR friend_requests.friend_id = users.id)
  #       AND (friend_requests.friend_id = #{id} OR friend_requests.user_id = #{id})
  #     SQL
    
  #   User.joins(join_statement)
  #       .where( friendships: { id: nil }, friend_requests: { id: nil} )
  #       .where.not(id: id)
  # end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open('app/assets/images/default_profile.jpg'), filename: 'default_profile.jpg', content_type: 'image/jpg')
    end
  end
end
