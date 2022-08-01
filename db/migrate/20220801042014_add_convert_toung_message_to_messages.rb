class AddConvertToungMessageToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :convert_young_message, :string
  end
end
