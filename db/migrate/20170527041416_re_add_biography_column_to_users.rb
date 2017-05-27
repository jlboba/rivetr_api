class ReAddBiographyColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :biography, :string
  end
end
