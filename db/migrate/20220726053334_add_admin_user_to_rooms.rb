class AddAdminUserToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :admin_user, :integer
  end
end
