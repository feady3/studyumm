class AddColmnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :icon_file, :text
  end
end
