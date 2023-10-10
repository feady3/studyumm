class RemoveMadebyFromGroup < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :madeby, :string
  end
end
