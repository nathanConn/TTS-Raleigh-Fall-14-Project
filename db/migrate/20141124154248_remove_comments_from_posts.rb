class RemoveCommentsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :comments, :string
  end
end
