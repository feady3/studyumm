class RemoveIconExtFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :icon_extname, :text
  end
end
