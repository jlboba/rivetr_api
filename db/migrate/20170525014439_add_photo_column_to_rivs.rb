class AddPhotoColumnToRivs < ActiveRecord::Migration[5.0]
  def change
    add_column :rivs, :photo, :string
  end
end
