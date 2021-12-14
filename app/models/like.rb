class Like < ApplicationRecord
  belongs_to :user_post
  belongs_to :user
end
