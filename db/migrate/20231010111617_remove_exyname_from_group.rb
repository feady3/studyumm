class RemoveExynameFromGroup < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :extname, :string
  end
end
