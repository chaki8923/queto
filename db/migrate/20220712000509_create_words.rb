class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :term
      t.string :conversion
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
