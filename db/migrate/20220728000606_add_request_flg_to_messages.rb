class AddRequestFlgToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :request_flg, :boolean
  end
end
