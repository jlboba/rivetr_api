class AddColumnToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :explanation, :string
  end
end
