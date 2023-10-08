class AddIconToGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :icon_file, :text
  end
end
