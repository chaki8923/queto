class CreateOldJudgements < ActiveRecord::Migration[6.1]
  def change
    create_table :old_judgements do |t|
      t.string :title
      t.string :image

      t.timestamps
    end
  end
end
