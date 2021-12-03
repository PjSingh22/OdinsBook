class FriendRequest < ApplicationRecord
  validate :not_self
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private 

  def not_self
    errors.add(:friend, "can't be the same as user") if user == friend
  end
end
