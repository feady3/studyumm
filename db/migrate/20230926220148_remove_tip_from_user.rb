class RemoveTipFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :tip, :text
  end
end
