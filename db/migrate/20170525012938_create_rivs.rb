class CreateRivs < ActiveRecord::Migration[5.0]
  def change
    create_table :rivs do |t|
      t.string :content
      t.integer :likes

      t.timestamps
    end
  end
end
