class AddConvertMessageToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :convert_message, :string
  end
end
