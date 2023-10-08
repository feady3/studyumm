class AddDetailsToGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :icon_extname, :text
  end
end
