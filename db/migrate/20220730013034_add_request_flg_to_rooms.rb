class AddRequestFlgToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :request_flg, :boolean
  end
end
