class RemoveDateFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :date, :string
  end
end
