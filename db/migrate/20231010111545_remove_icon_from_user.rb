class RemoveIconFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :icon, :binary
  end
end
