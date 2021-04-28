class AddUsersNameToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :users_name, :string
    add_column :rooms, :image_id, :string
  end
end
