class AddForeignKeysToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :user_id, :integer
    add_column :replies, :riv_id, :integer
  end
end
