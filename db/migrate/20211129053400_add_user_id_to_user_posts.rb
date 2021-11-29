class AddUserIdToUserPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :user_posts, :user_id, :integer
  end
end
