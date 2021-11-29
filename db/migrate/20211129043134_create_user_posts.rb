class CreateUserPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_posts do |t|
      t.string :message

      t.timestamps
    end
  end
end
