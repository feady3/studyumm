class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.text :uniqid
      t.text :name
      t.text :in_which

      t.timestamps
    end
  end
end
