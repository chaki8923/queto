class RenameConvertMessageColumnToMessage < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :convert_message, :convert_old_message
  end
end
