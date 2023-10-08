class AddInWhichToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :in_which, :text
  end
end
