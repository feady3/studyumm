class AddIconToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :icon, :text
  end
end
