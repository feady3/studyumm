class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :uniqid
      t.text :email
      t.text :user_id
      t.text :user_name
      t.text :password
      t.text :icon_extname

      t.timestamps
    end
  end
end
