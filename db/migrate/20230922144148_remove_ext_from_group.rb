class RemoveExtFromGroup < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :icon_extname, :text
  end
end
