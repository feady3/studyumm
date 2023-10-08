class CreateGrouplogs < ActiveRecord::Migration[7.0]
  def change
    create_table :grouplogs do |t|
      t.text :user_uniqid
      t.text :group_uniqid

      t.timestamps
    end
  end
end
