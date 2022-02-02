class AddUserIdToPostsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :api_v1_posts, :user_id, :integer
    add_index :api_v1_posts, :user_id
  end
end
