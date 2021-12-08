class FriendRequest < ApplicationRecord
  validate :not_self
  validate :not_friends
  validate :not_pending
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private 

  def not_self
    errors.add(:friend, "can't be the same as user") if user == friend
  end

  def not_friends
    errors.add(:friend, 'is already a friend') if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, 'already requested friendship') if user.pending_friends.include?(friend)
  end
end
