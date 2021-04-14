class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :users_name
      t.string :image_id
      t.text :introduction 
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end
