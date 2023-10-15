class CreateFriendslogs < ActiveRecord::Migration[7.0]
  def change
    create_table :friendslogs do |t|
      t.string :from
      t.string :to
      t.integer :status

      t.timestamps
    end
  end
end
