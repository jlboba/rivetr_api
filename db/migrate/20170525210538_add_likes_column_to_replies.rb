class AddLikesColumnToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :likes, :integer
  end
end
