class AddForeignKeyToRivs < ActiveRecord::Migration[5.0]
  def change
    add_column :rivs, :user_id, :integer
  end
end
