class RenameFollowColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :follows, :followee_id, :followed_id
  end
end
