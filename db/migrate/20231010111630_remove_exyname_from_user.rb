class RemoveExynameFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :extname, :string
  end
end
