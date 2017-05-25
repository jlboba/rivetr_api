class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :display_name
      t.string :password
      t.string :profile_photo
      t.string :language_learning
      t.string :language_known

      t.timestamps
    end
  end
end
